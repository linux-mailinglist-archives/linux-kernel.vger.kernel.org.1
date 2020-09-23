Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318B9275374
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgIWImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgIWImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:42:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:42:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m13so13733413otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QnP1kj2mE0hE9g8J+nOCGThcmIPrimRMKmT9maIQtY=;
        b=kh8jcq+bc74yGE8I02uysNJ4EEk700NIeRnGbO288dvoiE3fIAXHFfSieWr+6J83+T
         PMSC1VlZ5NJHJv11l3fPYP6rTQOwhAYsDppj+MsDL6O6N/6Zremw3y2gggW2boPfd0OI
         edWGnYLCNLGGyy59gFP1Hc3v3dMfNplbZAZgm//mdQisk8J9+3ii9Rkq7EmNDUdBnjA6
         9kP8ovLcgP9lC8EAl4fqfeQf50MlXt0G0x/RG/dB1x+krPwR+8Kwz8meQPjMYuEqdh4X
         sGEiX/Ir9rPFOf/z/rL4EeDJcj0oup9N2PhngkONWKl2Ahh/F1+9DKosEYHaGs/cyTAW
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QnP1kj2mE0hE9g8J+nOCGThcmIPrimRMKmT9maIQtY=;
        b=g5UIeuf/KnrPcr8eG7R6ZbLDLwwI0YpnP8x+ADRmEOqR6axmiiVQS1J6jbp9FeEwe8
         GhPT/8p3LBioSw7AdN9f1RLp6Izv7fSmwKMwBrJ9C6kAXBdt7GxB0GQG48EM+CDFiwL/
         7EYFQshcPIgX1Zp0j7+ftqT9OTqqIxdbhC9nROf+tIzbVF5Sy998f01syeFn+l4neEVn
         N2z3sB1lHU2vKBsn5DG/nac4M8nC5cJEmrPiMGJVP6lrQ5yFITMeI0FJza6EMDUoVcAL
         XZX0dFmUwOZhcdbCISTkcQjcFBB/WfmC2DYeQFRMCcSO378qs8b5LqjymUptb0JAjw8g
         Yjxw==
X-Gm-Message-State: AOAM530etMAabAAucoy3V2hyPORI9X6ebG1iTj+K9MD2xinLZgd9IUNE
        6JvEo/QcCKsBlhGIr3tQP0EWanjjCCR1EZ9nhhl/IkEEoho=
X-Google-Smtp-Source: ABdhPJyRbJBJjoUXs/VfYByW9RtyqhVapBDWiTy/ktYTIq/O5rsbIbY623qLVrSbKCtD5MQNbPtk4VakYTrPZYwhQHI=
X-Received: by 2002:a9d:5a92:: with SMTP id w18mr5293707oth.145.1600850537111;
 Wed, 23 Sep 2020 01:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <3dfdda44-3564-1775-c844-f7a2680c9c58@linuxfoundation.org>
In-Reply-To: <3dfdda44-3564-1775-c844-f7a2680c9c58@linuxfoundation.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 23 Sep 2020 11:41:50 +0300
Message-ID: <CAFCwf11Fg8gH6wMO5aPqwtNovgB153J2vNWdLF_zrua5b6Qetw@mail.gmail.com>
Subject: Re: drivers/misc/habanalabs: atomic_t api usage inconsistencies
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Lee Jones <lee.jones@linaro.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 1:08 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> All,
>
> While I was looking at the atomic_t api usages for an unrelated issue,
> I noticed free_slots_cnt in struct hl_cq incerment/decrement/reads are
> not consistent.
>
> atomic_inc() and atomic_set() are used, however instead of atomic_read()
> the value is referenced directly in
> drivers/misc/habanalabs/common/hw_queue.c
>
> hl_queue_add_ptr()
> atomic_t *free_slots = &hdev->completion_queue[q->cq_id].free_slots_cnt;
>
> hl_hw_queue_schedule_cs()
>
> atomic_t *free_slots = &hdev->completion_queue[i].free_slots_cnt;
>
> Any reason why this is necessary. I don't know that this is causing
> any problems, it is just odd that access is inconsistent.
>
> thanks,
> -- Shuah

Hi Shuah,
Thanks for taking notice of this issue :)
We will take a deeper look and fix the inconsistencies, although I
must say that we didn't notice any impact of this issue.
Thanks again.
Oded
