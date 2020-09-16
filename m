Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44C26CA93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgIPUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbgIPReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:34:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3BC0698E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:52:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so5698373ljd.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
        b=rNTpNjloivgL4IIauQWwsnW3KxFixBc/ITJAbmTyYNUMIyMEtpg9ZBa48r6s6fWkYd
         /NfUhyCTCCGtfo4ijiup9gAKreg7Bs7UIPUy0PiJqYyXqvz79OMc2HMYFSibNNsuytD+
         1GRo7G6lEiQwDX+QJ7aWDh8rHqBvf6EyxvLp2yy5T9ENaAZDZzpf4RqYI4x/oCagOemc
         Ja0kUPbj7gs0YCQEf5nPzBV1F46VmAvwn5sEw7qX0W9GCZMqTz8aSq5ygPvz1N+shfms
         3aJJ+nYGGWY+EnxEmJ+aeLDed6RubyY6R3r4JDiejlYeeNMii+nbcxI3mM0jyTSPfW6v
         C8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8u3YZmN9VS48Zs6GcqxY9P1vdOnn+WbobUW/vlRpyk=;
        b=TrjpGwsk4RLh9NFo57X87PGSl5Qk9/1vIFBdiW4GqSR/DnQFSEMTZF4qoljTWZwEZG
         NsWfGRepn7gnUFmNDeMufFu2l335GOsQDw2QGM7KF3ONwlawLP8p/jft1R2r5/yCCCh+
         rYsCMG497Mp0JsznKnQSv5tlYA8BPnhJdTkM1c0y42YtKVtgBg4T9rJSu/FVBkVqgY6B
         wepi5PDNNj0TuEkA3fmb/QGTdxP9DY4xe2kBcBm+YXGuVhl/dHJ17IQbvNHRIal1Mk0R
         9L2SVC7J5Hde1/2ayAZQeVv1BY+2NHPrEYxBaxcPjMhuF8X6yjfruJfrmSVMjSglDBdr
         dtcA==
X-Gm-Message-State: AOAM531C1emeckxcGotpHnA+SKniFHNDyUt9o4dtcZ8Fgn/u0/KHkmSw
        3MMcmK2cwtCd0bOH/RfIirVNGqBbo2BOgPkK3gA=
X-Google-Smtp-Source: ABdhPJzc002ZLUmgbuaE62WjRqkY0WfMHJ0a+m0maYHyQ6/Z/CBGbgoyR3VB9GpneRsAU37REZo3nFwFnQ/HWmLHjIE=
X-Received: by 2002:a2e:1444:: with SMTP id 4mr7758634lju.218.1600257125682;
 Wed, 16 Sep 2020 04:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
In-Reply-To: <CAOMZO5Dyo5J8SRWYLyh3bxwtcuAH=r6pcQg7-vtXfO2H6n4Exg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Sep 2020 08:51:54 -0300
Message-ID: <CAOMZO5CEViX6E8sNo0LROk3Y92_BCezHDpfBqMaQK_J4kT24yw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: update the register list
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 8:47 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Knob kmg

Please ignore. It seems my cellphone wanted to write something.
