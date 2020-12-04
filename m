Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF42CEC59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbgLDKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:40:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42105 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgLDKko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:40:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id f18so6024208ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hlZCJEKzokNwCxy9PppGO+4osNv7sekOt95QGYGMFIY=;
        b=bcFKfgkSywKYNtxmBE9c/THT8w9St4Vgl+QYc1IEhdDkA6SUUHwaSf7sDv/vB8qt9Z
         sbXW26PzfZ0yB0mRb2WjuR4WbchVWqrr3WNpyV+eFzPn5oESb3CUAXi5bJzDo55Kvp8z
         n4PqB+mcBbpQ29q4WBDMVwZnJ5V/bUnMhfKcSEBKR+AsINmLM0G2dKm9IeuKq6Kk4k1c
         ouLLyOYZ+9McnHiEix4tyVR6NKRSxZWWEN+06g7y7Y2aI2cxtBvws98Gzsn7nUeUACVV
         1YbBdT6fmhJLztHYSrjIajQwRfqroZgthvZwoXFckR5uyMIACBB+F63ujq4SoVDr/RDQ
         xS/A==
X-Gm-Message-State: AOAM532IMpbwRj/dLowSzTw9h9iIfC7Zy87CusHJhc1L+DHSNdbplhy2
        C8yJhSsFnGb+MAG8f44RSL8=
X-Google-Smtp-Source: ABdhPJwJfv10aOeyJIlJZY7U4xVm/2/Apb5jMujh/Ugx1ulLYSPkB2FbOrnNq0jrlcThClHnr5QLnw==
X-Received: by 2002:a05:651c:323:: with SMTP id b3mr3029571ljp.452.1607078397416;
        Fri, 04 Dec 2020 02:39:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id m16sm1515838lfa.57.2020.12.04.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:39:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl8Vq-0005Ys-Fa; Fri, 04 Dec 2020 11:40:30 +0100
Date:   Fri, 4 Dec 2020 11:40:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>, elder@kernel.org,
        gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH] staging: greybus: audio: Add missing unlock in
 gbaudio_dapm_free_controls()
Message-ID: <X8oSHkQZFHCv+Fza@localhost>
References: <20201204021350.28182-1-wanghai38@huawei.com>
 <X8n2CL58pQ/077rQ@localhost>
 <d95dac95-09d0-66bb-4f3b-5ffa154be174@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d95dac95-09d0-66bb-4f3b-5ffa154be174@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 05:19:25PM +0800, wanghai (M) wrote:
> 
> 在 2020/12/4 16:40, Johan Hovold 写道:
> > On Fri, Dec 04, 2020 at 10:13:50AM +0800, Wang Hai wrote:
> >> Add the missing unlock before return from function
> >> gbaudio_dapm_free_controls() in the error handling case.
> >>
> >> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> >> ---
> >>   drivers/staging/greybus/audio_helper.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> >> index 237531ba60f3..293675dbea10 100644
> >> --- a/drivers/staging/greybus/audio_helper.c
> >> +++ b/drivers/staging/greybus/audio_helper.c
> >> @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
> >>   		if (!w) {
> >>   			dev_err(dapm->dev, "%s: widget not found\n",
> >>   				widget->name);
> >> +			mutex_unlock(&dapm->card->dapm_mutex);
> >>   			return -EINVAL;
> >>   		}
> >>   		widget++;
> > This superficially looks correct, but there seems to be another bug in
> > this function. It can be used free an array of widgets, but if one of
> > them isn't found we just leak the rest. Perhaps that return should
> > rather be "widget++; continue;".
> >
> I think this is a good idea, should I send a v2 patch?

Let's just wait a bit and see what Vaibhav or Mark says first.

Johan
