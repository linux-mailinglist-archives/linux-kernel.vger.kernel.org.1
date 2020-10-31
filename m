Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B902A18BE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgJaQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 12:37:23 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BA5C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 09:37:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l16so9891656eds.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+NPfT8JKlCYRXYxFv0mKYw4TjmxjjOYGUynmMasNWs=;
        b=HKQdcZkK6WB/k/MXp+RFjtk9xh8eLggIn1uWnMTWOiVRLI4xoF8bsLANX0ZwmkLvoX
         lZmyyN7u7VCtM1TuI/74ZAVp1dFD4buY864JmFrByJQTMaBTCbAN8In/eYve+Cznzcax
         SrUifVkVu35WMSZEPZEQWm+8hfvsxH0YOpYH5icNL1bkRjQDB5PMcof/5l6yD+wbDK+K
         N959Enhya263RDXN558/FflJNj9/r/mrAXjb4BYKMx8rC/nJCYYcAptmWwe57AM6rpJh
         0CR6hV7rAxOSDiAf9PG20XpUJDWwIJGBdUFpBLgmt+2lYGQ8qyG8Pi6YueZ5QMa5GkHf
         P0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+NPfT8JKlCYRXYxFv0mKYw4TjmxjjOYGUynmMasNWs=;
        b=ZWYHt7N5EjtVnczfgdI2LmzXoR+KJTrDmYKPWbgVxmecw3Sfd2TqkNb6opRNJ7I8g+
         4qsWR+fvp2FoXbHgT6S5OajycQoWOTBpO7dcrIIbF+jo1eDbOGYP/Lfht/PAEGTbWuAm
         jyssct/17ZU+9hpX9xVKeBeeaqQQv6g0v0OU5Ap9vh1UeLhI/e5Ab89JT+MoSYWYmbOx
         PdM3pA7hU7tYRWAerFXJPAS2tbU4P7VcCney8GPuZ8101XZ1uJnoQwUiZ3dcE5YtA+nY
         /zNrGDaUgi1V2ql+M4qSJ+79+77+ZQahruKXZ6bYNuDWGNznCccT4cwTumEdL/MwRVNV
         S/xw==
X-Gm-Message-State: AOAM533Rf2t/kG4tgwWSzWZ6CKFgMKY2w2GnoEwA43Z+g8Vq/TDiE1PM
        krWATrpfBdWr90YcF7p/HE8Y0ouwFuNE84iDF8g=
X-Google-Smtp-Source: ABdhPJxIpSPjgXyS13YEIZD5ljPoARHrmOI4hcOBu31gcWonS6angIRDwgk/lV0siRgSia/7Tt/dwMY2SaeGyqMMTpg=
X-Received: by 2002:aa7:c704:: with SMTP id i4mr8380910edq.51.1604162241771;
 Sat, 31 Oct 2020 09:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201031094345.6984-1-rppt@kernel.org>
In-Reply-To: <20201031094345.6984-1-rppt@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 31 Oct 2020 09:37:09 -0700
Message-ID: <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Ard Biesheuvel <ardb@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> Please let me know how do you prefer to take it upstream.
> If needed this can go via memblock tree.

Going through the memblock tree sounds right to me.

-- 
Thanks.
-- Max
