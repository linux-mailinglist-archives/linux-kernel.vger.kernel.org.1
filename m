Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC32C7C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgK3BOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgK3BOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:14:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162FC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:14:15 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id w15so12497772oie.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ci5CHLJxKEcy3QWlP5ZvQNWjEsU1uJaTooeTMXCOkpM=;
        b=VJyTZOT2W29g9lbzViVerqyxYm7t7mekhgBqzEWmnluCOlHr2+wAAXF2oBjzVFQTdl
         IVfHGeqn6AgbopUWPbI3iiRViRmWoo0w5XHuKhWOnWIpdgV8DwxmpEpt39eMuiM/TYEo
         I38gNqc8yOFe2xA1nLldGR6sm272WxkmrazpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ci5CHLJxKEcy3QWlP5ZvQNWjEsU1uJaTooeTMXCOkpM=;
        b=mUwVzSqgMLcLij50UmYqWPQsJs7vSDnT3jAKX0dH+rb9sKQUsulRAtQKUxo2lz3jIr
         rYF5s/sAw2+DXqu1Gqj6IlDXUkLaGduV7GqNGuwAEntv//Pslg0wDbACQ8nxtlj+pk0A
         T2EaKsK7MhWd00sVfRxcUMpJOliL7WfcGm4GOck7aXWiPtCFLn1OzfeQWmUP4EFt682I
         bG4cRSsJEZ2YJqMuup6spxBhVaQTBLDP3mNyH7Ec9fUuw8dY66TuKqUR488ZfjpCRXlK
         99HUmXQvif4DkLHVw5Prf1PRD1NZdF+ZGDmUJYrznLMNYm5lv4A5KqzN39c+B0kVSx86
         TJHg==
X-Gm-Message-State: AOAM53098Fg0FzD3rgfqiU7WWGmxxZWcpaJS21PM/mnEI0YM3tQrf08G
        XNgST4XuFEo+1o3hwFem9lmz+aIQ6DOnrpJS9Ipa7g==
X-Google-Smtp-Source: ABdhPJymLyefZTD/4eV25dOV/S5KuIzuKplJyzh8FiRAmYTfgDr8hG8J+7cMZ8JYzSdefgfeq0Wd7eeQhUWW/l4oDB8=
X-Received: by 2002:aca:f3d6:: with SMTP id r205mr12752793oih.152.1606698854248;
 Sun, 29 Nov 2020 17:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130115603.48e91a19@canb.auug.org.au>
In-Reply-To: <20201130115603.48e91a19@canb.auug.org.au>
From:   Paul Barker <pbarker@konsulko.com>
Date:   Mon, 30 Nov 2020 01:14:03 +0000
Message-ID: <CAM9ZRVsq_VwYpuW70V7Dnfmqc7WXYcwsirGOo94B03Lp0uGyPQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the hwmon-staging tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 00:56, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the hwmon-staging tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> drivers/hwmon/pwm-fan.c: In function 'pwm_fan_is_visible':
> drivers/hwmon/pwm-fan.c:167:22: warning: unused variable 'ctx' [-Wunused-variable]
>   167 |  struct pwm_fan_ctx *ctx = (struct pwm_fan_ctx *)data;
>       |                      ^~~
>
> Introduced by commit
>
>   439ed83acc19 ("hwmon: (pwm-fan) Convert to hwmon_device_register_with_info API")
>

Ah yes. I removed the code that used ctx but forgot to remove the
assignment itself. I'm surprised it didn't generate a warning for me.

I can fix it up tomorrow and send a v3 patch series.

Thanks,

-- 
Paul Barker
Konsulko Group
