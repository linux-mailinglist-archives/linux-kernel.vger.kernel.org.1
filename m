Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD73011A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbhAWAYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbhAWAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:24:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:23:27 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s3so169419edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nASzEGEYiM7l5vJ0ku8u1eYMEEDv8/o90ST1BqSPIHs=;
        b=Y/n/6EdrkaKnAfk2rv/VXc7jfsJeI0V7J9yg2e0E6W531ZL3tu2neS99NHnmXglfsY
         fyl07BiNAaXGPuplq7EhcaJ+aLYPB9s55W8NbF/GTvJmdBVKmJnJ5vBOeIAiMSEEXe1Q
         wIYoA5qh1dvGOEzpTO5YFEnBFZeTOaf9ms3Y9t0oBV7qx1Z43eyrM4evF152MHimQ+qt
         qSbd18nI+DOsCJ/Vb0LlPONcbx72CoBXCxw1qgvMLpgxGax+KUxZHwHXiSBhnpoSoVHD
         Oqw6O5k6K5yDNSkriVVimVtNU5zXyqqyud7/AdDQeEYMRF4v42l8cPt5H6yB3Xwqm/sI
         Ypsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nASzEGEYiM7l5vJ0ku8u1eYMEEDv8/o90ST1BqSPIHs=;
        b=mdZsBbQVdOmE3sE/8kchGbuMwKIfZInVMWhHHr1Krw5fDiPFhlNpNoR2XSlrGGHf03
         nuCe2Qnp0wJUmVsAk8Nrcw9z1BWvXYTOcTbCf1K9rBERKjKsHxqpTxDOTj9yXzIM6ks7
         dFk/enjwnP4GnPvg4PvWSzTPPcDd6qGID+zlyEVtJmwmUGNALZnRYwuDHPF5svMAx1aB
         CpzDHqnt2n3HEWOpRpydKiZ+ASkIZ2R32D6Lvv1NRHU1bxq4RGsHffObAYQ9sOv8t0/X
         TRdmOaN3qj2slOlve7L77hUBwv5dIm7fWalMamHppRzuL+4MiWlCRaWEgETLGN3bKV77
         PEUQ==
X-Gm-Message-State: AOAM5337+q3L8FX5F7GRL4xvYvJrwVR/DX/b8bqRC/hC5WMEDkqi6PVN
        Mew9MiM4VVagL6OmUfn1eLKtd4q1E+37SkQp2OQk+A==
X-Google-Smtp-Source: ABdhPJx8H682K2MhREMpmnfodyFM5qPM1Xn2/gEbfTj5ogtTDhKlSh95epEtcqfRBJWob2V4vgFrK2ooMYqgR8olmYI=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr12125edv.116.1611361406044;
 Fri, 22 Jan 2021 16:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-6-pasha.tatashin@soleen.com> <d19f4bc5-ad5b-5dad-0d50-271817b6c9aa@arm.com>
In-Reply-To: <d19f4bc5-ad5b-5dad-0d50-271817b6c9aa@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 19:22:50 -0500
Message-ID: <CA+CK2bB41z-0+KDHmwbgpS8x071B69asP9dfN4oU=ME6GqNs2w@mail.gmail.com>
Subject: Re: [PATCH v9 05/18] arm64: trans_pgd: pass NULL instead of init_mm
 to *_populate functions
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Acked-by: James Morse <james.morse@arm.com>

Thank you for the review.
Pasha

>
>
> Thanks,
>
> James
