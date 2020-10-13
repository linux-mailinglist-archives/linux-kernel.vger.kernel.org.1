Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FB28CB75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgJMKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:16:17 -0400
Received: from foss.arm.com ([217.140.110.172]:52858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJMKQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93A3A31B;
        Tue, 13 Oct 2020 03:16:11 -0700 (PDT)
Received: from bogus (unknown [10.57.16.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FFBA3F66B;
        Tue, 13 Oct 2020 03:16:10 -0700 (PDT)
Date:   Tue, 13 Oct 2020 11:16:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Add missing Rx size re-initialisation
Message-ID: <20201013101604.GA7040@bogus>
References: <20201008143722.21888-2-etienne.carriere@linaro.org>
 <20201012141746.32575-1-sudeep.holla@arm.com>
 <CAN5uoS_GHXv-RHJACJMJqN_xRSSWuv=mTPW_aHZv5U6PjK16xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS_GHXv-RHJACJMJqN_xRSSWuv=mTPW_aHZv5U6PjK16xg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:58:09AM +0200, Etienne Carriere wrote:
> On Mon, 12 Oct 2020 at 16:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Few commands provide the list of description partially and require
> > to be called consecutively until all the descriptors are fetched
> > completely. In such cases, we don't release the buffers and reuse
> > them for consecutive transmits.
> >
> > However, currently we don't reset the Rx size which will be set as
> > per the response for the last transmit. This may result in incorrect
> > response size being interpretted as the firmware may repond with size
> > greater than the one set but we read only upto the size set by previous
> > response.
> >
> > Let us reset the receive buffer size to max possible in such cases as
> > we don't know the exact size of the response.
> >
> > Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
> > Reported-by: Etienne Carriere <etienne.carriere@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/base.c    | 2 ++
> >  drivers/firmware/arm_scmi/clock.c   | 2 ++
> >  drivers/firmware/arm_scmi/common.h  | 8 ++++++++
> >  drivers/firmware/arm_scmi/perf.c    | 2 ++
> >  drivers/firmware/arm_scmi/sensors.c | 2 ++
> >  5 files changed, 16 insertions(+)
> >
> > Hi Etienne,
> >
> > I reworked this in a different way and hence dropped your authorship and added
> > reported by. If you prefer I can attribute you as author. I want to push
> > 2,4,5/5 as fixes and hence the rush.
> 
> Hi Sudeep,
> 
> Tags are fine like that.
> As for the content, it looks good to me.

Thanks.

> When trying to apply this, I failed, but I guess I'm not testing over
> the same kernel tree/branch as you.

Ah OK. I wasn't sure if we had touch code around these recently.
Anyway, I have all these on my for-next/scmi[1][2]

--
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-next/scmi
[2] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/scmi

> All in one, I am really fine with this change, I think it does the job
> 
> Regards,
> Etienne
> 
> >
> > Regards,
> > Sudeep
> >
> > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > index 9853bd3c4d45..017e5d8bd869 100644
> > --- a/drivers/firmware/arm_scmi/base.c
> > +++ b/drivers/firmware/arm_scmi/base.c
> > @@ -197,6 +197,8 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
> >                         protocols_imp[tot_num_ret + loop] = *(list + loop);
> >
> >                 tot_num_ret += loop_num_ret;
> > +
> > +               scmi_reset_rx_to_maxsz(handle, t);
> >         } while (loop_num_ret);
> >
> >         scmi_xfer_put(handle, t);
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index c1cfe3ee3d55..4645677d86f1 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -192,6 +192,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> >                 }
> >
> >                 tot_rate_cnt += num_returned;
> > +
> > +               scmi_reset_rx_to_maxsz(handle, t);
> >                 /*
> >                  * check for both returned and remaining to avoid infinite
> >                  * loop due to buggy firmware
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 37fb583f1bf5..a3f1bc44b1de 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -245,6 +245,14 @@ extern const struct scmi_desc scmi_mailbox_desc;
> >  extern const struct scmi_desc scmi_smc_desc;
> >  #endif
> >
> > +static inline void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
> > +                                         struct scmi_xfer *xfer)
> > +{
> > +       struct scmi_info *info = handle_to_scmi_info(handle);
> > +
> > +       xfer->rx.len = info->desc->max_msg_size;
> > +}
> > +
> >  void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
> >  void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
> >
> > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > index ed475b40bd08..82fb3babff72 100644
> > --- a/drivers/firmware/arm_scmi/perf.c
> > +++ b/drivers/firmware/arm_scmi/perf.c
> > @@ -304,6 +304,8 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
> >                 }
> >
> >                 tot_opp_cnt += num_returned;
> > +
> > +               scmi_reset_rx_to_maxsz(handle, t);
> >                 /*
> >                  * check for both returned and remaining to avoid infinite
> >                  * loop due to buggy firmware
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 9703cf6356a0..b4232d611033 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -166,6 +166,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
> >                 }
> >
> >                 desc_index += num_returned;
> > +
> > +               scmi_reset_rx_to_maxsz(handle, t);
> >                 /*
> >                  * check for both returned and remaining to avoid infinite
> >                  * loop due to buggy firmware
> > --
> > 2.17.1
> >
