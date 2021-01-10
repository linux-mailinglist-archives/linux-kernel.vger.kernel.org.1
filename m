Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574E82F0A80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAJXvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAJXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:51:48 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F88C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 15:51:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u21so1636291lja.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TeXerxLFQDRy1M/7+6jRhfeAjoOXsFHoiOadjCR5Gxo=;
        b=Qt+slJnfi7kKerWix4WQ5h3IJviGUsa6pyl2XSZOa5Jguu/1sbrujcumGoqzIniiru
         QNv6GWf9r3YnXEybcNqWJgIJ1XTxXRieyeSHs9ZIiKMRjBDVi+TJ3rUG4FoIOeN/Sba9
         EKhHiqY4DBXj8uDRXj/mM9GuNN0nehxPDPN7cGJJfd0iXW8q7JW9QpfjO0vnWHjhR4+R
         NFQv2goTLNLfTyqFooMd7Ad79y/ZlR/gx+h+QhPhrLxhM9M2fjqAplekdwBhK31EyqbG
         CBtTuPAG2ILts4fD/jqhIKUVJ5RkCCONSzoku5Z5V0SfuLx7XEwiw2m9bzwYfB038CJT
         EMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeXerxLFQDRy1M/7+6jRhfeAjoOXsFHoiOadjCR5Gxo=;
        b=cV9UNwaqPY3/JmFgsQX2sUp0wmeyKk7+RKcbvSHdo1xXecBnKNScTuFRpK3yi4ET20
         w++HUHcpebsPNqPP5qmsNELAIdwadvqLgjChov/wAbSfTpEzgba8ugjfs3helL1aZh/0
         2ccjyI0GL9fxHZp5iNIgdyqtmHfl2dCvVOkZtTrXF0ThovkqO5pzeRS0j8SzQu9CODYN
         vOPRVf/qt8LEZxmpzs822ABYLvJTd4oBfTxELlLmSTwKOqQv8q2uSnRc6E8M22sG6f6m
         zBOZYy3oPIk9Z7YVdhFlQC1fsIaV1agmUdwFpEHMljzw1xNxVz9bJwStn1W2n822pty5
         cLPg==
X-Gm-Message-State: AOAM530MCK0uYmFE6lSNRD2NZUBfI5x4d8NzN+XOQFM2/XpY2OmC443m
        on6gkb28ev9i/577BFBW/+tvmJGffN/OOFuimtEQOp8UinLmUw==
X-Google-Smtp-Source: ABdhPJwqHKxSHgkILumAzY5OKQLD8YP9VBC1kI0H6ZXJ4LVIag60LgqtDk6Pt+7IEB25C6ZhnMGQxCj3WFsKVjDJ03E=
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr6529624ljf.444.1610322666121;
 Sun, 10 Jan 2021 15:51:06 -0800 (PST)
MIME-Version: 1.0
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley> <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley> <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley>
In-Reply-To: <20210110200606.GD7264@ripley>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 10 Jan 2021 20:50:54 -0300
Message-ID: <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 5:09 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> here the schematics and my dts. The board is using a LVDS connector for
> the display.

The schematics shows the GKTW70SDAD1SD panel in the J4 connector, not
the LVDS J7 connector.

> https://www.variscite.de/wp-content/uploads/2017/12/VAR-6ULCustomboard-Schematics.pdf
> https://lore.kernel.org/linux-arm-kernel/1610144511-19018-3-git-send-email-oliver.graute@gmail.com/

As I mentioned earlier you should remove the display timings from the
dts when using the compatible string for the panel.

power-supply = <&reg_touch_3v3> is not correct, as the reg_touch_3v3
does not power the LCD.

Another hint is to use the PLL5_VIDEO as the clock source for the
lcdif controller as done in the imx6ul evk dtsi.

It would also help if you could share the complete boot log.
