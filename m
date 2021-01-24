Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE019301E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbhAXSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAXSYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:24:25 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8A3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 10:23:44 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i17so12606698ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TH9aJiZaZ+U+nPTcu3CY+tkY0xvrtG7s1l2Zo+h8cO4=;
        b=Ka9shkHHgV9WEq7pX8AAVnON0DFW0zXg4MklWvptRvP+GZYF+EIwZgZemzu5wAxTdI
         qF0/BbH/YJ31KGKjPlwU5bcsaHOsBJOrbsXQAidUK4vs3mAIHIfp+q7pPZ3mQsZG5RdG
         7TK5O2QaChw0U7n6t9rOsmEMkPXzD57X/IhB+eOBCyqBRIFaIEFYFu498DCKDrDtjoD4
         EW++y28r2yQBF9l9t26Ami1yxLUGtIAhYwxRwys5is6oXF4AN6XGwa2DdrhCEtVHjtQD
         Lc1MTjaDJ0V2E5wsqkk7Evq31oF+/l/c3VkBXdqPLPAZMMVexA4HJmkVTfgqkTkCyxc8
         os1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH9aJiZaZ+U+nPTcu3CY+tkY0xvrtG7s1l2Zo+h8cO4=;
        b=XXZy39ET7tnCFb/v6DoEcf7pTP4jsG0cfZEFb68GAhsHflenW/6xiTPAgpo6MbCvNv
         5WUOMLvRVeIrcrB6emCk/CyYPmTkQHnDUlIYvt6RhoWskAQBWEY0Z6MaOc1h9gImwMFJ
         GnhS7vJQfvOawYjRDjq6xQudFi/7Elq5a5XV3/4z66ShoDqPZWcekXLiqvzN0D98TwF+
         JwyQrenic5VNVurvM+HYBwMjP3lfCiXHFg8qD9iITAkqpnH7qEnra4UFl1d07E6B8qyF
         x6xoL5UyFSPb7zhIQKivESzlxf5i1bSR7dHPZJ/Q4X9ErwodwjoPbXr1my/4CdRdo+AD
         6nqw==
X-Gm-Message-State: AOAM531zVz3u8Z3lQ64Vj4fNFi+1SzYN4VW22hudO2HZn2ghwP56KK2p
        gGoN/1jtJk3wqISMBqsXXbSecF2IFrixAowYtTI=
X-Google-Smtp-Source: ABdhPJyA16J8LV8cCCPSvM5OAhYSU5/W39HzjLKpUXDGhkruBIKzwDjo45yCUZPzQjPtNOdMwhodtc1+pBzaHRr2LNA=
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr250307ljn.50.1611512622979;
 Sun, 24 Jan 2021 10:23:42 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMvRzY_JHH4cPtxQ3nsYrsEJFgD0Wh5Aimx+iGB8GnY3g@mail.gmail.com>
 <20210124111047.13404-1-hdanton@sina.com>
In-Reply-To: <20210124111047.13404-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 24 Jan 2021 23:23:31 +0500
Message-ID: <CABXGCsMY5eEefYLvnqtws8MRAqHOaDW9JwfsCPnLZydLDQqyuA@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jan 2021 at 16:11, Hillf Danton <hdanton@sina.com> wrote:
>
> If it is supposed due to the race between pool->stale_lock and
> pool->lock that are both protecting the buddy list_head then adding
> another one can be a cure.  The diff below is not for any test.

Thanks for looking at the issue.
Why the proposed patch not intended for testing?
It is not the final (optimal) variant?


-- 
Best Regards,
Mike Gavrilov.
