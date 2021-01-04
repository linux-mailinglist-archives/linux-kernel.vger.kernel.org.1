Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200C92E936B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhADKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbhADKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:33:41 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55233C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 02:32:56 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so63087519lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HCz7TH+Lju0Src9+qXHN7KrHSyyYI2VUc2VnENnxqO0=;
        b=P7B59xQ4kaz+iFxqZyw/7NU4/fbH6DM6CqiNIHtugbCmnm4e+shCXxVWHpaYmCTU1E
         tLYtCY8HEzvEDDaJNwxrkjbUB6zj6jCDtKE7O4soVW8bL3ko29u6FI8DTx79doK9OtJY
         LTHtHj6K3WOgq7jpXSXi4ROiyOlfcgIB01y6ViP07lDs024b8+DKZm4/2jCH9x3L312R
         wm5OtTzxLI8FwoZhYMTB4bi7E4nczgPZI9jhbksFIytvG73c1zpmnRt2LaXgbEO9Cq7y
         L5uWWCPROo/k2rMwmOQ8AMNT0XRpiyNGShOccWYU7DFaCsk3V1yVbglpJM+XpLm23Xml
         LtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HCz7TH+Lju0Src9+qXHN7KrHSyyYI2VUc2VnENnxqO0=;
        b=PQnNLdcYl6lmcbFrQfTKPcIj21O8u9vzz9Z1Becz+2QF3hTTbVc/hOCBFg3P6pNLRq
         0sBg9ApoXhZ/m/TheBGNmOR97WZ0H8i3pprXg+mgVBdbyxfvEbZ/Qdr21fLUrv3giENK
         nIAKs6NlF9DDwM0xDjsJKUiYTC+ir/HDyr7A2CmPwZetVnZ5bMrCsG7CjUvGRU4rU40/
         EU4fyRsCUi2e4nu1T6ttnQZyOvaVGu9EBWX6xtsEQpI/4ykLvs9dBgExLUm7xJ7o4wVW
         918RBOPGIa+drhEAdQG0APtBQD8S/zMicHr0aPjbeRzwJugQ4+LU1ydvOCzdhaLrl1x1
         /sUg==
X-Gm-Message-State: AOAM533Mw3/+ShILvmLZRenPCzS4xAg4LobQP358Jj7tqQvx7ugOWlqj
        OottsGwBRs9MRuVvUAPOLRwH3yAy5mIoyCFy9JA=
X-Google-Smtp-Source: ABdhPJz02RDUruDLO8byaABiFcVdu06QqT1rycWY5JmRCzodNVURaf1BejpoD1t6D1Jm1n1/Xwf/LKs4krOTcDvFJQ0=
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr37254333ljj.448.1609756374832;
 Mon, 04 Jan 2021 02:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20201231085252.69831-1-krzk@kernel.org>
In-Reply-To: <20201231085252.69831-1-krzk@kernel.org>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 4 Jan 2021 19:32:17 +0900
Message-ID: <CAGTfZH20USDdNLLkjC5QsxYnQU6hnG4esbf7gf91pvw0GqZPBQ@mail.gmail.com>
Subject: Re: [PATCH] extcon: Add stubs for extcon_register_notifier_all() functions
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        kbuild-all@lists.01.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Dec 31, 2020 at 5:56 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add stubs for extcon_register_notifier_all() function for !CONFIG_EXTCON
> case.  This is useful for compile testing and for drivers which use
> EXTCON but do not require it (therefore do not depend on CONFIG_EXTCON).
>
> Fixes: 815429b39d94 ("extcon: Add new extcon_register_notifier_all() to monitor all external connectors")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/linux/extcon.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index fd183fb9c20f..0c19010da77f 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -271,6 +271,29 @@ static inline  void devm_extcon_unregister_notifier(struct device *dev,
>                                 struct extcon_dev *edev, unsigned int id,
>                                 struct notifier_block *nb) { }
>
> +static inline int extcon_register_notifier_all(struct extcon_dev *edev,
> +                                              struct notifier_block *nb)
> +{
> +       return 0;
> +}
> +
> +static inline int extcon_unregister_notifier_all(struct extcon_dev *edev,
> +                                                struct notifier_block *nb)
> +{
> +       return 0;
> +}
> +
> +static inline int devm_extcon_register_notifier_all(struct device *dev,
> +                                                   struct extcon_dev *edev,
> +                                                   struct notifier_block *nb)
> +{
> +       return 0;
> +}
> +
> +static inline void devm_extcon_unregister_notifier_all(struct device *dev,
> +                                                      struct extcon_dev *edev,
> +                                                      struct notifier_block *nb) { }
> +
>  static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  {
>         return ERR_PTR(-ENODEV);
> --
> 2.25.1
>

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
