Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7762AE5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgKKBdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKKBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:33:38 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D2FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:33:38 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l12so526821ilo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEpISxBy+aDC4QvyXYCOtMBCKcYpAR6IL02cyswjaAo=;
        b=Qd1z0OlKef2151ovFX2pjwaMIb8nsyf6lbgVhiRIWlYRC1msQ0kh2HEwkVINeBxByt
         OJFw3ktT3nHwBvrCliByCTCqJdDm1o+SrVuXE7phzWWGa1Rg71NW9E8jlAPk/HdGXrDB
         Mq/gUjPQN7ySS0k/tRainaa1LmcrFZ9dEKhii4ePmAQdzHvitXdeYN7PGPQ5Ud+J4Y3K
         SyFUF0sKUh+V5VhDRRUY1wp/Ad1heAKCCmvIvQa1x+Qe9wiy1j0h1ncid5S9bag/Bviq
         CmZv1Udl3ghkT8xOGCZt/irX9GzVr3iypNgnoJIpmFO0TI8zzdPNklbf7QV1ujcsvkxj
         F1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEpISxBy+aDC4QvyXYCOtMBCKcYpAR6IL02cyswjaAo=;
        b=UaOlY+2GExncb3upafsRhav8cS+RhpVS0NIvjrMz5pIxOUsPI/JMxEsnOeVgF9Tuzi
         nbCPVuiErs3XuevQNkTPi/ksonpm/Rd7GzcI4pkxdiUlRm1c9PzTgxgTajAAkvK05ojp
         Ka+r0Q81RV01JCs/EYGd6MfpoGu3sL/IaWbpFfKQyeXz7fUnqIvlGkrCIzxi4hMRYLLl
         eVfUbSog6dOALV2lXiAGMud8f3XI6avY0gcsKAF6cEo8Aamxcm4m20TGDJS1kBN/1NCN
         q7eTOaYnhdnIYWi2ADOnxt1EGdrtMN/lmg8jaS2+542xPkallxMt3nx7Lz/zcHvmAA6d
         m2iQ==
X-Gm-Message-State: AOAM531tGQTLHyy3kzA29yCOtt4QmC4D1R7VmAEDqcI2o9OC6I0g5TbB
        nqCwrN4eT2PixWCtYldPfI0EVcP4+WYz7r/beVsEpBB4GNc=
X-Google-Smtp-Source: ABdhPJz1oW3tiIGxL6BXt/S8n6yC7JJSsQj5i26qF/0/3uwF/BK3mBTn1Hjuua6lzMszpUFmabOMRBMj0tr83PZACaw=
X-Received: by 2002:a92:8541:: with SMTP id f62mr17400895ilh.9.1605058417938;
 Tue, 10 Nov 2020 17:33:37 -0800 (PST)
MIME-Version: 1.0
References: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
 <20201102231420.1833852-1-ztong0001@gmail.com> <7d978bf40c5845e8b89a740250ba958a@AcuMS.aculab.com>
 <CAA5qM4C+UGB_SXW5OeWKPtNkXyVCfwwB_ct9wps0Lj6VhvTawg@mail.gmail.com>
 <2e1ec234135349c58993097b84ea10b2@AcuMS.aculab.com> <CAA5qM4DnB+K4ESxeFrCtDRrpbCojngr0hcsdb_OSXKuChtN5Xg@mail.gmail.com>
In-Reply-To: <CAA5qM4DnB+K4ESxeFrCtDRrpbCojngr0hcsdb_OSXKuChtN5Xg@mail.gmail.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 10 Nov 2020 20:33:27 -0500
Message-ID: <CAA5qM4CQhDUD80W109C0N=2uMNhB=8eTtUPy2wu3PV_RK2KAmw@mail.gmail.com>
Subject: Re: [PATCH v3] qnx4: qnx4_block_map error handling
To:     David Laight <David.Laight@aculab.com>
Cc:     Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was wondering if it is still possible to get this fixed.
I am curious what is the acceptable way to fix this?
Thanks,
- Tong
