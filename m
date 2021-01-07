Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439FF2EC858
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbhAGCxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:53:40 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84042C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:53:00 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so3792346pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjM/12FZ440jYsJkVJrWv4LsYWfcjGwNNBn9yloYJhQ=;
        b=AmbNg67TWQuuAe08RuN+7R2vJB69lMLJRGhpJ/K1pSCxw8TJUTOQQYXadvlMBZ2EpW
         DwzK57DTuLMA7YvnQ+aHMi0/YIhtDU+9FDz/1p4qlqtaBzF30xazKzFdzE5ObatvUIa3
         YHADcrUF+7BCL4QGvaXltlXz71cJ1n1GXSqxHbnJZq0R5ZP+VIoMKIIkgyfsg96RoBs4
         rvA6CbrTYLFl8yyy/K1GJ/iIPF6xgfEfcPpHStj8iMZvYLGcon1nE31CUQiGSFPeDI+W
         D09cpTTipC1sT6OJ6eNNUKeeHw61rUmuj6Mkv/+IMMQvasYBTqBm32CCKzq14Bsjf9Ri
         VgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjM/12FZ440jYsJkVJrWv4LsYWfcjGwNNBn9yloYJhQ=;
        b=CJGEUe9Qle1PBSSb9K+fytc915YcO69NAkp55BSCU9BhoPF+DTkmm7b9vRo5IVz+4r
         7h0vsouboyB5zENq6o3WG0GntueEbx18c/LVrI8neQqkwktGpLTJnb4EdfR3f7Vn645s
         kIoV8+6oDsdybwybFpuRo3Fgx9vmdzqWMiONglVOZSyypG1CyPqLzpgA+pnIzvv1Q1sA
         2MfiCw0E1SEHYZPVCnxntXUd0B4gSEFjuvWOnH0n6921wN3gBn8erm0itnGBBDoO1hRc
         CwHjOX4sfVUKBRiXkgniCx4ji++E3kTPkas76WFasFdJLTipuYhjjxCF8o+Qdbe+FkYv
         LGVg==
X-Gm-Message-State: AOAM531V9gspqWxrEhO3+7rxPPN7KcSeKeVgIOHSipFphvocaZewjlOL
        pBoSs6Qc2dW6hByfA/oqWHPn7HhLUqyScYcZ7uur0obfupqsHDzaj+M=
X-Google-Smtp-Source: ABdhPJwQ6lLwtKUmB5u0bfXMnFW/1FXwZEG1smcYuzInOoacCoij6J4Pd4ZSgfvOX2D82Fr+7TSTGXafXy2ks+cOigw=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr6601863pfp.49.1609987979866; Wed, 06
 Jan 2021 18:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-2-songmuchun@bytedance.com> <20210106161327.GR13207@dhcp22.suse.cz>
In-Reply-To: <20210106161327.GR13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 10:52:21 +0800
Message-ID: <CAMZfGtUTkeeswiS8M1aq67JXztrjQwzqd0aZ9cgvgPZEEQQPEQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:13 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-01-21 16:47:34, Muchun Song wrote:
> > If the refcount is one when it is migrated, it means that the page
> > was freed from under us. So we are done and do not need to migrate.
>
> Is this common enough that it would warrant the explicit check for each
> migration?

Are you worried about the overhead caused by the check? Thanks.

> --
> Michal Hocko
> SUSE Labs
