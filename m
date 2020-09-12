Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B394D267B54
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgILQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgILQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 12:10:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F351C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:09:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u21so15023959ljl.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfTGBer8RATBfD/BSJV0RKCtt8U1lAtJViRDynBOF3Y=;
        b=ycL9Gnq0/OzDgoOKpHTuxmOkkI6Wqxi6nmetrLaT1oRp9EIFNJUGyMQBljjJc0nG0v
         8DnLbLZVq+iAsyYymh3bjnH7D7YlKJv8aBvY55T6z30DyAP7rYZXn/ZxAuZylk/+jf5g
         IGeMcMBnmhV6ts6k29Dta0ZpiTk+7JBWJzKVFhcgknuTFGPlSiDKeskyD8S4lX3ShfVP
         4UUIKVJcosIBOpTICwljI997syj93RrvH8j8+T5ZdCHUych916vW5KU2Qycwa5WQ4FYp
         aVI7ZBtqN9vlqQpSzPmZ+o1RdGeQ7Zg9Jxz7Jp8Pk+YefbujkTtz3WC8lwE3hNu1jIIr
         avrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfTGBer8RATBfD/BSJV0RKCtt8U1lAtJViRDynBOF3Y=;
        b=baHFV0g4NAx/wbFe1EFVbmGzzsEUDKThanZk51WxyXITyp2+ghQ3mp7jqs4lSwBn7J
         MBbvQKE1Z2fwWHubkAVYxNqI+8XQKd2G/03w4BmjCHUhPKHIM3pJ35frW6CChT3cUBIc
         YkHTPHa6ejG4Nl/8EcWePDKKL+MOTwxAQeh4ag5ebUfbBiMTeHWwcXLsNd15c2eha1wN
         MOjafY81OtyP+G3tc4j8p2FYWK6xzparWxrgtLeS9GfpGadlsmNacJMmYJaYuRh47/tO
         n9gZeqW6fmc8uaMASzCEFdqBrIP2krGyrjkphOH+kvs5ovoUqudRKUChmSwdd7+aGivs
         gq7A==
X-Gm-Message-State: AOAM531OHf8K7GLRQUh4IXX6bN45fUIqO/Lw5Lv2b9I/Uv1uFxY97tK3
        fFG/24Dmdxrr9V+zVA8eswT1m4NSo5MgrAe/NDh0gA==
X-Google-Smtp-Source: ABdhPJy6ZAMEu7rVKygsqJ8Y9WlGqdtya7BDyOamAGm5sKv1JX++wYpkxrw3S1w7pibhY9m++Hz/VmzIUzLA6GfJrgc=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr2426839ljl.104.1599926995989;
 Sat, 12 Sep 2020 09:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <f32130bf-cfd4-b1bf-538c-dbc9ee2d947a@eaxlabs.cz>
In-Reply-To: <f32130bf-cfd4-b1bf-538c-dbc9ee2d947a@eaxlabs.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 18:09:45 +0200
Message-ID: <CACRpkdZ5YU=ix9Qd8KBfqK9i9e3q-2THt06BJiTTEMUkGap_NQ@mail.gmail.com>
Subject: Re: pinctrl: sx150x bug
To:     Martin DEVERA <devik@eaxlabs.cz>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 11:28 AM Martin DEVERA <devik@eaxlabs.cz> wrote:

> I encountered bug in SX1502 expander driver in 5.7.7. Here is relevant
> DTS part:
>
> compatible = "semtech,sx1502q";
> gpio4_cfg_pins: gpio2-cfg {
>                          pins = "gpio5";
>                          output-high;
>      };
>
> And part of OOPS:
>
> [    0.673996] [<c023cfa6>] (gpiochip_get_data) from [<c023b235>]
> (sx150x_gpio_direction_output+0xd)
> [    0.683259] [<c023b235>] (sx150x_gpio_direction_output) from
> [<c023b363>] (sx150x_pinconf_set+0x)
> [    0.692796] [<c023b363>] (sx150x_pinconf_set) from [<c0238fef>]
> (pinconf_apply_setting+0x39/0x7e)
> [    0.701635] [<c0238fef>] (pinconf_apply_setting) from [<c0236c77>]
> (pinctrl_commit_state+0xa5/0x)
> [    0.710648] [<c0236c77>] (pinctrl_commit_state) from [<c0237e03>]
> (pinctrl_enable+0xff/0x1d4)
> [    0.719139] [<c0237e03>] (pinctrl_enable) from [<c023b791>]
> (sx150x_probe+0x1a3/0x358)
> [    0.727027] [<c023b791>] (sx150x_probe) from [<c02c38bf>]
> (i2c_device_probe+0x1bb/0x1dc)
>
> The problem is that sx150x_pinconf_set uses sx150x_gpio_direction_output
> but gpio is not
> setup yet. Patch below fixes it but I'm not sure whether is it correct:

I simply rebased and applied this patch now.

Yours,
Linus Walleij
