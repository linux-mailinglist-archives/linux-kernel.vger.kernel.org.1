Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4C276E16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgIXKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:01:56 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80FEC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:01:55 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 7so1760163vsp.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gG3TGcCNO5Ud46BLsD5sWYjJ4a2/lbvQEvsThJh9qEE=;
        b=hQhpC06Ymj7cC8How6wpx/M6kpoh2hUM3rs7Bn/DEVq7exX7SYtOvSGy2zCLXmsKlM
         OJQHMnRg4h0CiOPzqoyY/YIJGvfoeba2F+Hh0RMLSzH7bwZwQ3hicK82QyGZsrZe34uo
         LGd74K0kJFSGxcLk2zhAWIgXfxM/rCqaBI4ZGrJCidXmQb0SL5R6KNeuzsazzi74MFbI
         c7qLWdgsnELJr5mfyIHjkf+RaShex8rGp6dbr9Po2Ynj1N49H+uHRK+8tZE57msCqjrX
         nXlJqInYQmBlioA5Q66kt9IvD9fcJnqWWzIzhw8YgYjdS2Jd2DkN69iEP0EThWXwmIRK
         CWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gG3TGcCNO5Ud46BLsD5sWYjJ4a2/lbvQEvsThJh9qEE=;
        b=OpATSuXTPOTTJ6pCmNRRRDHcber/i+RZ2zPLNovAbgRqqMQPYcKYlBz04a6tx2F76J
         dVd6IyE2LPCQ1rwa1fCWSuFDOX2ZhT8DOZlBEVekGY8Zp2x+mP+vP/Q+sJ6uJYOFQXmx
         ozVz6Ippsy2mmAaFTD78ihDi8K00ssivbPFTLY+KrnHAkUkXCOStTHHtV8+/tQso+W/W
         yTSrFl9FW64GwQX0rILmEIrv/Z+iTwHHRTdL/nlS8e+Pvl6YD4xUv08VJfhPuEsu6Msq
         1e2opcqj9ENtXkJ7KnGj+joJBvjOUufieBbobEm3wije13PyKPmZM5P71KP/3TzJhaQH
         ByIQ==
X-Gm-Message-State: AOAM530DrUJN5lbqb6pqbVSO8lzHTT//6wULzQNTmYjKH2ovyHSbOD+a
        7nyVEaEkj8kI/X5MPZUnrCiN1B9k/70cPqm79cVZ0eY2wHMg2Q==
X-Google-Smtp-Source: ABdhPJxUih1NAxRvdeuAQspE35mzVcLTI9OvmDzHzpjLuL/YjdrJDhNNSvqbD4VQsTi0lAZoQbkSY9LRl2ncsKSjl14=
X-Received: by 2002:a67:3009:: with SMTP id w9mr3342555vsw.19.1600941714934;
 Thu, 24 Sep 2020 03:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <1600933221-3496-1-git-send-email-rui_feng@realsil.com.cn>
 <202009241736.oeTpczA1%lkp@intel.com> <26c3f3e19bbb440798a791c5c7359b14@realsil.com.cn>
In-Reply-To: <26c3f3e19bbb440798a791c5c7359b14@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 12:01:17 +0200
Message-ID: <CAPDyKFpko92mcdim1UsnzGcPZD+KG0bNsq+DPhB-U+_kZ2Cr0w@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 11:48, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> Hi Hansson,
>
> This patch is based on your patch "mmc: core: Initial support for SD expr=
ess card/host",
> If this patch is compiled alone, there must be errors.
> What should I do in this situation?

You need to pick my patch from the patchtracker or the mailing-list
and fold into your submission as part of a series. In this way the
0-build server will build patches stacked on top of each other.

Moreover, if possible, I would suggest to split cardreader changes
from mmc host changes. In this way you would get a series along the
lines of below (not sure what order is best).

PATCH 1/3: mmc core changes.
PATCH 2/3. cardreader changes.
PATCH 3/3. mmc host changes.

Kind regards
Uffe

>
> Thanks
>
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on char-misc/char-misc-testing] [also build test=
 ERROR
> > on soc/for-next linus/master v5.9-rc6 next-20200923] [If your patch is =
applied
> > to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:
> > https://github.com/0day-ci/linux/commits/rui_feng-realsil-com-cn/mmc-rt=
sx-A
> > dd-SD-Express-mode-support-for-RTS5261/20200924-154122
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-mis=
c.git
> > 26ed5146bd17cbcd0fb84e358902ac244728a3f3
> > config: arc-allyesconfig (attached as .config)
> > compiler: arceb-elf-gcc (GCC) 9.3.0
> > reproduce (this is a W=3D1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cros=
s -O
> > ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0
> > make.cross ARCH=3Darc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_power_on':
> > >> drivers/mmc/host/rtsx_pci_sdmmc.c:931:20: error: 'MMC_CAP2_SD_EXP'
> > undeclared (first use in this function); did you mean 'MMC_CAP2_NO_SD'?
> >      931 |    mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V);
> >          |                    ^~~~~~~~~~~~~~~
> >          |                    MMC_CAP2_NO_SD
> >    drivers/mmc/host/rtsx_pci_sdmmc.c:931:20: note: each undeclared
> > identifier is reported only once for each function it appears in
> > >> drivers/mmc/host/rtsx_pci_sdmmc.c:931:38: error:
> > 'MMC_CAP2_SD_EXP_1_2V' undeclared (first use in this function); did you
> > mean 'MMC_CAP2_HS400_1_2V'?
> >      931 |    mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V);
> >          |
> > ^~~~~~~~~~~~~~~~~~~~
> >          |
> > MMC_CAP2_HS400_1_2V
> >    drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_get_cd':
> >    drivers/mmc/host/rtsx_pci_sdmmc.c:1141:17: error: 'MMC_CAP2_SD_EXP'
> > undeclared (first use in this function); did you mean 'MMC_CAP2_NO_SD'?
> >     1141 |   mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> >          |                 ^~~~~~~~~~~~~~~
> >          |                 MMC_CAP2_NO_SD
> >    drivers/mmc/host/rtsx_pci_sdmmc.c:1141:35: error:
> > 'MMC_CAP2_SD_EXP_1_2V' undeclared (first use in this function); did you
> > mean 'MMC_CAP2_HS400_1_2V'?
> >     1141 |   mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> >          |
> > ^~~~~~~~~~~~~~~~~~~~
> >          |
> > MMC_CAP2_HS400_1_2V
> >    drivers/mmc/host/rtsx_pci_sdmmc.c: At top level:
> > >> drivers/mmc/host/rtsx_pci_sdmmc.c:1376:3: error: 'const struct
> > mmc_host_ops' has no member named 'init_sd_express'
> >     1376 |  .init_sd_express =3D sdmmc_init_sd_express,
> >          |   ^~~~~~~~~~~~~~~
> >    drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'init_extra_caps':
> >    drivers/mmc/host/rtsx_pci_sdmmc.c:1399:17: error: 'MMC_CAP2_SD_EXP'
> > undeclared (first use in this function); did you mean 'MMC_CAP2_NO_SD'?
> >     1399 |   mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> >          |                 ^~~~~~~~~~~~~~~
> >          |                 MMC_CAP2_NO_SD
> >    drivers/mmc/host/rtsx_pci_sdmmc.c:1399:35: error:
> > 'MMC_CAP2_SD_EXP_1_2V' undeclared (first use in this function); did you
> > mean 'MMC_CAP2_HS400_1_2V'?
> >     1399 |   mmc->caps2 |=3D MMC_CAP2_SD_EXP |
> > MMC_CAP2_SD_EXP_1_2V;
> >          |
> > ^~~~~~~~~~~~~~~~~~~~
> >          |
> > MMC_CAP2_HS400_1_2V
> >
> > #
> > https://github.com/0day-ci/linux/commit/37daa224f78ef228349cee981d690b7
> > 35fb9bb2b
> > git remote add linux-review https://github.com/0day-ci/linux git fetch =
--no-tags
> > linux-review
> > rui_feng-realsil-com-cn/mmc-rtsx-Add-SD-Express-mode-support-for-RTS526=
1/
> > 20200924-154122
> > git checkout 37daa224f78ef228349cee981d690b735fb9bb2b
> > vim +931 drivers/mmc/host/rtsx_pci_sdmmc.c
> >
> >    894
> >    895        static int sd_power_on(struct realtek_pci_sdmmc *host)
> >    896        {
> >    897                struct rtsx_pcr *pcr =3D host->pcr;
> >    898                struct mmc_host *mmc =3D host->mmc;
> >    899                int err;
> >    900                u32 val;
> >    901
> >    902                if (host->power_state =3D=3D SDMMC_POWER_ON)
> >    903                        return 0;
> >    904
> >    905                rtsx_pci_init_cmd(pcr);
> >    906                rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT,=
 0x07,
> > SD_MOD_SEL);
> >    907                rtsx_pci_add_cmd(pcr, WRITE_REG_CMD,
> > CARD_SHARE_MODE,
> >    908                                CARD_SHARE_MASK, CARD_SHARE_48_SD=
);
> >    909                rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_CLK_EN,
> >    910                                SD_CLK_EN, SD_CLK_EN);
> >    911                err =3D rtsx_pci_send_cmd(pcr, 100);
> >    912                if (err < 0)
> >    913                        return err;
> >    914
> >    915                err =3D rtsx_pci_card_pull_ctl_enable(pcr, RTSX_S=
D_CARD);
> >    916                if (err < 0)
> >    917                        return err;
> >    918
> >    919                err =3D rtsx_pci_card_power_on(pcr, RTSX_SD_CARD)=
;
> >    920                if (err < 0)
> >    921                        return err;
> >    922
> >    923                err =3D rtsx_pci_write_register(pcr, CARD_OE, SD_=
OUTPUT_EN,
> > SD_OUTPUT_EN);
> >    924                if (err < 0)
> >    925                        return err;
> >    926
> >    927                if (PCI_PID(pcr) =3D=3D PID_5261) {
> >    928                        val =3D rtsx_pci_readl(pcr, RTSX_BIPR);
> >    929                        if (val & SD_WRITE_PROTECT) {
> >    930                                pcr->extra_caps &=3D ~EXTRA_CAPS_=
SD_EXPRESS;
> >  > 931                                mmc->caps2 &=3D ~(MMC_CAP2_SD_EXP=
 |
> > MMC_CAP2_SD_EXP_1_2V);
> >    932                        }
> >    933                }
> >    934
> >    935                host->power_state =3D SDMMC_POWER_ON;
> >    936                return 0;
> >    937        }
> >    938
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > ------Please consider the environment before printing this e-mail.
