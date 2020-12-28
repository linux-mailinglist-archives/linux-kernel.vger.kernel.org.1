Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984FD2E6B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgL1W4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgL1VJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:09:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17CBC061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:09:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t30so12557498wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhuhFwDBpnue8NMFhTCdyQgKIPZtaS0TCc7EAkELyOk=;
        b=P1mGykHV5DcrKhwSVonNTIWBzaaisO/PBBF2I1RVPmMMHkpkgk+c2tPC36S481bmm1
         Eke0ftw+b1toxwEZpTC/UrEg6mvwRQ1LvjDGvE00ncnE59Qt9B+S6PMSkaQzPqE0Jion
         9h9nYq+akcjIshxL++XXnV9rNaOm+Q6SP0YhNpBTBzKYqtz84Bv/rJS9XT2hlslxsXbh
         NgWIXcMLWuB1UUlZPlnPoANWFJf5qqO+SqymDpr2BX0uP9RGAr7QQM4GOAcY3dyeuGjx
         yM8Zjck8y81SpngJFbdz8EnCaVEL5lPNhkBEM0WwcwdpxYI1kw0FIy8Z5Ynwq3uQHTBE
         qiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhuhFwDBpnue8NMFhTCdyQgKIPZtaS0TCc7EAkELyOk=;
        b=lBdWBMtLFPojv1OQNJimZshHFPQss7DaqXJqBOqycLkYPGP31wIng+1MgT40XdoJZK
         pIt7OmzmM5DYexHjNgbkfrdKaGrq32nDdL6Qg1DuxE2AhqJ4WPNWOh9bNbEkyQqblAE9
         t8bEjkRaK295VfcO3AMHkavcLPsEEK4oRbhQgKy/cbp7lRz09mNdMgOxTHcI4mZJIrK2
         eluu+IqMHs22C/greuH9oBZgfQy7IDFg0jfD8q0oj//0L4ynuA6bGk8VL8blXVuh1vsL
         tsTJ6++OdBf7uNqhcHxXay3MHSz8F1xnNj5O0bBeEiFbPknuDilh/GPV8PYX1T8ksFZZ
         c6TQ==
X-Gm-Message-State: AOAM533IxveJGA5R7SeR6Y7uyxvogwo+JFRHZFsOUkvNXiKkohp/yS/N
        +dNCkwFahaNlvZ73wd4EeGY3+TSFPawuwkKhuNQ=
X-Google-Smtp-Source: ABdhPJyLQP00+NgkTDvXJDf3P/BaUpBJcpB2dSx1VIzEvgnHs9knkAOD4CEH6S+8KuCruUJJrpWZrxlqTOJFumKpNKw=
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr52718987wrc.224.1609189741482;
 Mon, 28 Dec 2020 13:09:01 -0800 (PST)
MIME-Version: 1.0
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
 <1608762196-29871-2-git-send-email-tharvey@gateworks.com> <CAGngYiXSyNXjxTHBVd13NfjexzZpOZb1dayWDWO7eV19xNr5wg@mail.gmail.com>
 <CAJ+vNU3in8f1zchYj=X3LFY8P6G-_zTeOvCQ1u_rjp8+Bdmicw@mail.gmail.com>
In-Reply-To: <CAJ+vNU3in8f1zchYj=X3LFY8P6G-_zTeOvCQ1u_rjp8+Bdmicw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 28 Dec 2020 16:08:49 -0500
Message-ID: <CAGngYiXiJq3Xp9fSrs21QcTzOHJC0Yg9OVU+5648_-pVgV5bvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development Kits
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     =?UTF-8?Q?Anders_R=C3=B8nningen?= <anders@ronningen.priv.no>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:55 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> I'm happy to test your patches for lan743x.
>

That's awesome ! I'll post them early in the new year, so that test + review can
happen in parallel.
