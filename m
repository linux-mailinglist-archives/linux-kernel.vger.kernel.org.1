Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A529A3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505707AbgJ0FJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:09:08 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40660 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436533AbgJ0FJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:09:07 -0400
Received: by mail-wm1-f53.google.com with SMTP id k18so114302wmj.5;
        Mon, 26 Oct 2020 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RufP3qjmXuxaUF3ybvzpTJBsD2XeZ/nZjEMXWLPO6xc=;
        b=pHRgxBKyDahbPCSBmbWVpuMhvlKklou1v6yEWFPk39BEQ7DvnEyI8jtWLwgjzi+cVb
         0QmhYfxK5/sAvomdEs+mj7+XdjxWFK+96FHrm+2nHy4Fdu0WaXyXWBk7D/34jpA53w3a
         XwXPDGHmheXNFNstNLHwHOGO4w5K2HXHb48GhyGnrN47LFkiR2SPyTj8f9GESZHEyxqv
         4A5R1VfESTfcdtJs+ght3T8MZLsQIkU5ZvRw6pX72yHub+WUIaO45nebGfgg8ThLBxiB
         /Nn8tOCUJAHiOLVaPizLV57/iq8tLU+ZcAolLElRsDHqRZ/SMrmw4/13Y9CoCn3LsjyZ
         AyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RufP3qjmXuxaUF3ybvzpTJBsD2XeZ/nZjEMXWLPO6xc=;
        b=MnJ8squXKyapHsZhLmYzxQE/lNR/+V6abx+xDCSp32yRxogvbKm76HxRw1Evye3SeH
         VoSVQ+xOeN4Yozoo9Nv72ctxKt5kLeESOOPIE6nYVfgUwgq3QUljGuD6ubv2GIDQC6jD
         gEVKLrexnYYJVqLOLoycIB/uC2TDzc7YmOYX1JOhV1H1OjZmbL6j50QiEVVlWJR4DVvr
         GYnTSnw2ACEey+pvbnU+SuTJBayg/YqcucZIzfgI2eI2/ffrl0iaYP2OP06l3D3Jlf7G
         BYx/+gkejVjmtgNYzUoJFEpMJYj/nUsWMNCH1oAzbIv3r8MLy25E9KxJy9ycGVxNFtJ4
         jL9Q==
X-Gm-Message-State: AOAM530N0fXdgEG15vsbDokwsp7rILZuEQugEm55dmRi0vE2I5U9rstM
        p/IzKzn1bzVHlrCDCVt2uBHIKDnFfNlYVj050BHrcOM/
X-Google-Smtp-Source: ABdhPJwrtIhVRO0bsExW0l59hMZ6Jl7KGYXzmJw2HVvxBa5qSgZGbovKe4rXFH2yL3H7bQqUFJnKMu2VReCssBiRyR4=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr621976wmj.146.1603775344036;
 Mon, 26 Oct 2020 22:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <29be54b5-5872-33ac-7c8e-998d77226a0a@amazon.com>
In-Reply-To: <29be54b5-5872-33ac-7c8e-998d77226a0a@amazon.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 27 Oct 2020 14:08:53 +0900
Message-ID: <CAM9d7ciF4WoPbiJSCBVpU4p6h92t9+ZEYGvDuMim_kfqUi58Dg@mail.gmail.com>
Subject: Re: Perf raw sample overflows perf record
To:     George Prekas <prekageo@amazon.com>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ LKML

On Sat, Oct 24, 2020 at 8:44 AM George Prekas <prekageo@amazon.com> wrote:
>
> The header of a perf sample has a u16 field for the size of the record.
> On the other hand, a PERF_SAMPLE_RAW has a u32 field for its size.
>
> I've written a test perf driver that creates large raw samples and it
> doesn't work correctly (as expected). For example, perf record fails with:
>
> Can't parse sample, err = -14
> 0x4688 [0x8]: failed to process type: 68 [Bad address]
>
> Is this expected? Is the developer of the perf driver responsible to
> make sure that each perf record does not exceed 64KB in size? If that's
> the case, I am wondering why the raw sample has a u32 for its size.

For the large records, you may consider an auxtrace interface.

Thanks
Namhyung
