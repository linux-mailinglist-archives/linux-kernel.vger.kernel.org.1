Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB342253C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGSTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGSTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:48:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80EC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:48:11 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so15972215ejq.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QvtOHHMUl6WBOj14DIr1cxsyacAZwqDni7dM4vSbf0w=;
        b=YBBPiSqIQIFrgEPWCIJe0FuG4hhDGdCUIr07jYqRamMggCpkZZ+YsArg7+IbUrKeu5
         oiCN0/+lw8WYzL7TmuZCLGXz0uQCOuKeq5F38avY3v5aftNe1APKwL47gm7Y+FNqsaC4
         jWwR+h+zKlcEGVkd84BUTlEQ6tclKMNhNvuiSmPrZf/jumwZ23juL9Xp0u0hiRx+OB3Z
         TCtWp2sr2wITH/qm1ehM3uzIMOdKxJ8a/Dyw0sv6K6ksi0kXOJHrcbdtPJ6rM5Uidfva
         ZpBXjNxYbpff+yCh+cy/pnXlF6QCUzWVlPl4slMa2Bm2JLVotdIB7J2HP6IawFpMhHtW
         BgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QvtOHHMUl6WBOj14DIr1cxsyacAZwqDni7dM4vSbf0w=;
        b=daarvl+KLaNGksZq3I974UdEKr7FFLz7ud1Acm5FSiGVxCleCmcxVs9VSDHVa56hdh
         rIUf5YQX8bC6iELCidKJGqXop7xBN0mPlB/tWjCPEe+g4YQtmiUVcdprYWJ3hysfjyyB
         06obHutVfPbSvuWCzs7+QrgVgl6MSt+k0AjkNrdgw6zri5GwpESNgvlhDfZS8CCTSjQx
         XNCywwVypp5X6dhGsGjdwUYULe290PAAecDbnpa6d8V2xQRs7qPIJqdr2/++8GXVbdco
         GsVxm2bvgUSWLOp5giytjVWPsStr76E+Z27Lmt1vke9y498KBHCMedlVstOqFGeN1EE/
         E0tQ==
X-Gm-Message-State: AOAM531LByxq3v4BIsSjCbsrZDxAnqbbv/9ZRH3FrT+IJYjoDcbk6P8+
        Swx6zTpXr7my0Vwji2NlDqNiIbPhAKyBKXej9nx3Aw==
X-Google-Smtp-Source: ABdhPJx8w9sV4iU22R9t2jjzAnoPOUObxKjnbiCTAt90GlUaR1pd8g7DpaW/hoayw/iarnt80Hu019JwSXrQCVdgtcM=
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr17338385ejx.97.1595188090204;
 Sun, 19 Jul 2020 12:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200716170914.3623060-1-yuhsuan@chromium.org>
 <CABXOdTffo_PoFytXTR0DthRgxrp9SLkTrg2Wp6dMDXXj060KFw@mail.gmail.com>
 <f53d5f7b-6d9a-af68-7a48-fbb411625336@collabora.com> <CABXOdTf2x4zK9n0WN2djLxCbfQynF4p5v_opwB-DsEyRnRAd4g@mail.gmail.com>
 <CAGvk5Prz_62Gzu98eZFDotzQOz5tMN72PB4UA9m315-PVfrsNQ@mail.gmail.com>
In-Reply-To: <CAGvk5Prz_62Gzu98eZFDotzQOz5tMN72PB4UA9m315-PVfrsNQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Sun, 19 Jul 2020 12:47:59 -0700
Message-ID: <CABXOdTckJ0bzODL6qmU4BtE5SSSNqNUmyQ2CA-LfBtEgKp7LPg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:51 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> Guenter Roeck <groeck@google.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=8817=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Thu, Jul 16, 2020 at 10:47 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Hi,
> > >
> > > On 16/7/20 19:23, Guenter Roeck wrote:
> > > > On Thu, Jul 16, 2020 at 10:09 AM Yu-Hsuan Hsu <yuhsuan@chromium.org=
> wrote:
> > > >>
> > > >> It is not guaranteed that I2S RX is disabled when the kernel booti=
ng.
> > > >> For example, if the kernel crashes while it is enabled, it will ke=
ep
> > > >> enabled until the next time EC reboots. Reset I2S RX when probing =
to
> > > >> fix this issue.
> > > >>
> > > >> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > > >> ---
> > > >>  drivers/platform/chrome/cros_ec_proto.c        | 7 ++++++-
> > > >>  include/linux/platform_data/cros_ec_commands.h | 1 +
> > > >>  sound/soc/codecs/cros_ec_codec.c               | 9 +++++++++
> > > >>  3 files changed, 16 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/pla=
tform/chrome/cros_ec_proto.c
> > > >> index 3e745e0fe092c..2c60690d7147c 100644
> > > >> --- a/drivers/platform/chrome/cros_ec_proto.c
> > > >> +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > >> @@ -572,7 +572,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_de=
vice *ec_dev,
> > > >>                 return -ENOTSUPP;
> > > >>         } else if (msg->result !=3D EC_RES_SUCCESS) {
> > > >>                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n",=
 msg->result);
> > > >> -               return -EPROTO;
> > > >> +               switch (msg->result) {
> > > >> +               case EC_RES_INVALID_PARAM:
> > > >> +                       return -EINVAL;
> > > >
> > > > As we have learned, this may impact other callers of
> > > > cros_ec_cmd_xfer_status() which only accept -EPROTO as error return
> > > > value. In addition to that, the code is odd:
> > > >
> > > >     if (msg->result =3D=3D EC_RES_INVALID_VERSION) {
> > > >         ...
> > > >     } else if (msg->result !=3D EC_RES_SUCCESS) {
> > > >         switch (msg->result) {
> > > >         ....
> > > >         }
> > > >     }
> > > >
> > >
> > > Ack, this is odd.
> > >
> > > > I really dislike the notion of changing error return values of
> > > > cros_ec_cmd_xfer_status() one by one. That can only cause ongoing
> > > > trouble with callers expecting specific error return codes (as we h=
ave
> > > > already seen).
> > > >
> > >
> > > Hmm, that's a good point. Ok.
> > >
> > > Let's apply the Guenter's patch that maps the errors *and* fix the ca=
llers of
> > > cros_ec_cmd_xfer_status which only accept -EPROTO (there are few).
> > >
> > > Yu-Hsuan, can you take care of this and send a patch series with all =
the
> > > required patches? If not, I can work on this next week.
> > >
> >
> > I can look into it as well. Let me know - I don't want to duplicate wor=
k.
> >
> > Guenter
> Hi Guenter,
> Really thanks for your assistance! Could you help me on those patches?
> Since you wrote that patch, I think it should be the most efficient
> way to make them merged.
>

Untested patch series is at crrev.com/c/2306731. I'll try to get a
successful CQ pass with both chromeos-5.4 and chromeos-4.19 and submit
the relevant patches upstream after it passes.

Guenter

> Thanks,
> Yu-Hsuan
>
> >
> > > Thanks,
> > >   Enric
> > >
> > > > Guenter
> > > >
> > > >> +               default:
> > > >> +                       return -EPROTO;
> > > >> +               }
> > > >>         }
> > > >>
> > > >>         return ret;
> > > >> diff --git a/include/linux/platform_data/cros_ec_commands.h b/incl=
ude/linux/platform_data/cros_ec_commands.h
> > > >> index 69210881ebac8..11ce917ca924c 100644
> > > >> --- a/include/linux/platform_data/cros_ec_commands.h
> > > >> +++ b/include/linux/platform_data/cros_ec_commands.h
> > > >> @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> > > >>         EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH =3D 0x2,
> > > >>         EC_CODEC_I2S_RX_SET_DAIFMT =3D 0x3,
> > > >>         EC_CODEC_I2S_RX_SET_BCLK =3D 0x4,
> > > >> +       EC_CODEC_I2S_RX_RESET =3D 0x5,
> > > >>         EC_CODEC_I2S_RX_SUBCMD_COUNT,
> > > >>  };
> > > >>
> > > >> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/c=
ros_ec_codec.c
> > > >> index f23956cf4ed84..b5ff30b7f1aa8 100644
> > > >> --- a/sound/soc/codecs/cros_ec_codec.c
> > > >> +++ b/sound/soc/codecs/cros_ec_codec.c
> > > >> @@ -1034,6 +1034,15 @@ static int cros_ec_codec_platform_probe(str=
uct platform_device *pdev)
> > > >>         }
> > > >>         priv->ec_capabilities =3D r.capabilities;
> > > >>
> > > >> +       /* Reset EC codec I2S RX. */
> > > >> +       p.cmd =3D EC_CODEC_I2S_RX_RESET;
> > > >> +       ret =3D send_ec_host_command(priv->ec_device, EC_CMD_EC_CO=
DEC_I2S_RX,
> > > >> +                                  (uint8_t *)&p, sizeof(p), NULL,=
 0);
> > > >> +       if (ret =3D=3D -EINVAL)
> > > >> +               dev_info(dev, "Missing reset command. Please updat=
e your EC firmware.\n");
> > > >> +       else if (ret)
> > > >> +               dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n",=
 ret);
> > > >> +
> > > >>         platform_set_drvdata(pdev, priv);
> > > >>
> > > >>         ret =3D devm_snd_soc_register_component(dev, &i2s_rx_compo=
nent_driver,
> > > >> --
> > > >> 2.27.0.389.gc38d7665816-goog
> > > >>
