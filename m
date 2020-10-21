Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC47C295556
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507322AbgJUXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507315AbgJUXuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:50:50 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E6C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:50:50 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h11so17288qvq.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1HD9V4l/NjXPn9fpmayxuMePExPcYuK0NWj56FlCogU=;
        b=PtxOUYJBaM2pPdS1ZdfS6FvCFFgfT5nXXp3ruVG0E/KoFA4VWFZ/q72sY7/MoNtkVG
         tZYgVIDNBw2HZk3vSLfo+j2o9dZ0PjIwg4NQw5Kz94CW2L76HxC6cSXaB4OMrPATT3qc
         t0qRvIo3N/xwV+X/RkASjIYxB7kHkZSragZ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1HD9V4l/NjXPn9fpmayxuMePExPcYuK0NWj56FlCogU=;
        b=bQyZoCglnLn6OhSYKPxI78kgfVtZKgCKe7csU8x/6kE1w8Bj72cGnhHjn4VVKSmObQ
         mVs/Pdqw8u3YB7cspBag4siQo3ATJ8WlrAF1h9oQnrCO0VUA2c+ZX4ELn0Gn3GpoXlMF
         y/j77T13WgFdDkPQ9n8CWGm3so2rFsD6O+q5B9hFKckxKyRnKwV2BuWtrOYwK5ooAzWM
         Q77ChoKsqr8BfwD0s6s6FhEJBP6wthFBJGJKykB1L6LIU1dL+mpRGjLlcdeWaOxYfpN5
         kiFOSr4+QcBbIIDz/9NfBjber9PJ6+MGoWCtBPKKBhrAr9iQ2Mlhx1BokjF6hDmDHsIR
         WETw==
X-Gm-Message-State: AOAM532QWo/iCCAKMAMLu7lHjh9fciaHz8bWUS1aFMhcNHqXj6EEGN/C
        rVJTwCDOEoL4vDugE1YzVdch/QgGRYNyjZVI0ajSpfEMzZE=
X-Google-Smtp-Source: ABdhPJxaFELAUAiGjkCQGZWsqD1uZ8FG2qI04DatiGbo7uJ/eB1y22uzaYqX3cCFUFivapomB22rZJhq33vxQM/0eog=
X-Received: by 2002:a05:6214:a0f:: with SMTP id dw15mr5119528qvb.44.1603324249193;
 Wed, 21 Oct 2020 16:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201021205317.708008-6-pmalani@chromium.org> <202010220607.vNb380XI-lkp@intel.com>
In-Reply-To: <202010220607.vNb380XI-lkp@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 21 Oct 2020 16:50:36 -0700
Message-ID: <CACeCKad0TowOcaxxuBA5iyq3X56inkiMxpsQ8WDmQtSV60_USQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 21, 2020 at 3:55 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Prashant,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on chrome-platform-linux/for-next]
> [also build test WARNING on linus/master v5.9 next-20201021]
> [cannot apply to linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Prashant-Malani/platform-chrome-cros_ec_typec-Register-partner-PD-information/20201022-045552
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
> config: microblaze-allyesconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/d95c360f8dc525bd78c299a987c1287867f766a2
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Prashant-Malani/platform-chrome-cros_ec_typec-Register-partner-PD-information/20201022-045552
>         git checkout d95c360f8dc525bd78c299a987c1287867f766a2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/platform/chrome/cros_ec_typec.c:698:5: warning: no previous prototype for 'cros_typec_cmds_supported' [-Wmissing-prototypes]
>      698 | int cros_typec_cmds_supported(struct cros_typec_data *typec)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~

Oops, I forgot the static (sorry!). I'll fix this in the next version,
but will avoid pushing another version for now in case there are other
comments.


>
> vim +/cros_typec_cmds_supported +698 drivers/platform/chrome/cros_ec_typec.c
>
>    696
>    697  /* Check the EC feature flags to see if TYPEC_* commands are supported. */
>  > 698  int cros_typec_cmds_supported(struct cros_typec_data *typec)
>    699  {
>    700          struct ec_response_get_features resp = {};
>    701          int ret;
>    702
>    703          ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_FEATURES, NULL, 0,
>    704                                      &resp, sizeof(resp));
>    705          if (ret < 0) {
>    706                  dev_warn(typec->dev,
>    707                           "Failed to get features, assuming typec commands unsupported.\n");
>    708                  return 0;
>    709          }
>    710
>    711          return resp.flags[EC_FEATURE_TYPEC_CMD / 32] & EC_FEATURE_MASK_1(EC_FEATURE_TYPEC_CMD);
>    712  }
>    713
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
