Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97D202528
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgFTQRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:17:07 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA4C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:17:07 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so13557536ejj.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvAgfTjcXFkPSa91lOsTKSl91buywUzLiGuCcM3OEbA=;
        b=gi2YfXtC+YREyXAAYGSXxMWJxvI6mIcBKWaR+AivlxT4pnDYEAMJEUF0rZDluwWiBr
         v6/t2PpA/6IyAm+vOLYNga7+eusqNP2nldIUsg51JJVgN86NeYgeVhkbBvoJVgcKDKxb
         m4SP9kPMLrIn2x69BfVi36HmZHRTSFgMqq/fWjN91tuPt+xB99IdICtEQt34aQZmSQB5
         RGqodhJsrDe1ysoc/P6T+zgfisR9JisPWNFFSCHiNlOvK7+8LuBFSjPKge4WMdOC2pax
         h/BRKQaqW+mtm1L7CyLz3KP4h/rII4a32OAuO5S1XNxvv6F0klHRxiz5tbGwmcg4sm16
         gIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvAgfTjcXFkPSa91lOsTKSl91buywUzLiGuCcM3OEbA=;
        b=s3wFTSejC0imCKfEgkjAs6lHVuF0YKg0tZY4kWAeto5QTIjXcDROlKTrtqaa7XV4LA
         yB0hNN6/iZoVKKmiX+YM4LTIXFzd9VIGEDS3eKFJ5REDMbnsf3lyZnzQ9kWpd5pfjJM7
         2k28gbhrq/8ZT2Bb8+7zKg0ir7m5PXVk4NSSd11B0i2Zeoh1Y9cZphpBa3WtsnUJqb6M
         3OhjNe4hnXn5pfxRvgi9+NEtP9S/f2R9idWR3tScPoZ+RqaRsD4eu4ExojRE3ny1aq6h
         RrMKtyEzG2Q0IDBmtX8CvZfDF/B4pe0ZuTz/VmNM8YaEvfIXq2W59lHC5OnJReFUW4uO
         QGfQ==
X-Gm-Message-State: AOAM530fn6bpPHMox8MX+qly4+C6A9D9ONADgj7ssp4E8c+l2lR07zZY
        7YIdCoWbbrTVKdsVAoh+zNzvTJzeqlYuH+DbbwQJg3C7
X-Google-Smtp-Source: ABdhPJwXyZk4gt0IG21r86cM0zaWKEIEo8piLpgi4sSOy5EXnN2eNTfyAa1yrtDj6XFepQ9HIsK2QLzMZL0k0T5E5aw=
X-Received: by 2002:a17:906:254f:: with SMTP id j15mr8383777ejb.162.1592669826117;
 Sat, 20 Jun 2020 09:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200620160136.21584-1-martin.blumenstingl@googlemail.com> <20200620161426.GR304147@lunn.ch>
In-Reply-To: <20200620161426.GR304147@lunn.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 20 Jun 2020 18:16:54 +0200
Message-ID: <CAFBinCBg3M4xz9w-M17hbiYTrMBPiDdE3RsjJsGTvJ7G_BTVjg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: Add the Ethernet "timing-adjustment" clock
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Jun 20, 2020 at 6:14 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Jun 20, 2020 at 06:01:36PM +0200, Martin Blumenstingl wrote:
> > Add the "timing-adjusment" clock now that we now that this is connected
> > to the PRG_ETHERNET registers. It is used internally to generate the
> > RGMII RX delay no the MAC side (if needed).
>
> s/no/on
>
> Sort of typ0 i make :-)
good catch, thanks!

while going through this I also noticed that there's a typ0 in
"timing-adjustment" (in the commit message only) and the word "know".
I'll fix all of this and re-send


Martin
