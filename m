Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AB27B00E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgI1Ohb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Ohb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:37:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F902C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:37:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x201so745416qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9un1wrj3PTq7hOjdkXB7DO4gRSAxULKefYKMKy1C5EE=;
        b=sztvg8Xsp3jxgm/0E9EynYjZfFNu2om3bJC76o5nTDvNglwdbCuzzmaQb8H0b/+kSY
         LUom5AjRWc/hF4w0ETOs2jm1wqT0zGh1vuc5M3/ZBs3/zfz7dmxgE6KzxORiCiNGUiPL
         RBrLw7HYU4FfM98r3x12Yw990FCmvwnhzqGenpSsAUA/4NCDgeWNBaPSjVpcLTFEVQLn
         2Bin7Mg8h807pMhAwhQOoIpKmn24mlFB3YoAXfnSv9HEtM+dsFWPjf45Is6StH8mR+7a
         KRbGND7jPeYCfYuyWceQ6JBLGbehOHQOxqZR9ZSBGurbcLsOqhfAj+KrtJBTulAEQhOo
         PfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9un1wrj3PTq7hOjdkXB7DO4gRSAxULKefYKMKy1C5EE=;
        b=m8djy7QFbF4lAmwUAB5KctD1JVrTM065EL9hh42sTwTkkK0VoeSVwCWB+A1F1RBKGU
         cDkNqRS0WxMfiYCHJfnR8MNbu3068j7yTxA/MVJ1to9bwQoiYp31983FZ+Dh/YibYm9I
         sM/Jzh7qmVjNE2xZ1Uwzbm168QzqHWKYaW1V6R1b8cLk0hnxfAaLCthmgPlkJjWjmfvt
         w1E4CrUiqvgxiuvmtNaLfjS2uoUnwQ7izk5/sznz7X87350JhYVEaaVnBoWFSu5dH1x8
         c+OD1xUwoX9UPiOVlfwAkGZ7OXTIKKqqBSITwrCjGQjCXMMpJNrVzwp+rdyLE8Zzv+c0
         BL0g==
X-Gm-Message-State: AOAM533zdoTumYjFQPVnY7OxA+ISY87ga4INMcVEumMUuiuasuk9LVnF
        QNgm3bt7sd2pTPmhuP3oq8s7AiVM8/aghsq0EYK2alXQnhYXHw==
X-Google-Smtp-Source: ABdhPJzXG4Z+PUZWrDnmIZWqoyferBYQbQhL6n5BxoPBa6Vpji0JCsf+gAYNZMDhCNDDC2Ms05s3UYgj16JdaYd38zo=
X-Received: by 2002:a37:a5d6:: with SMTP id o205mr1649836qke.314.1601303850655;
 Mon, 28 Sep 2020 07:37:30 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Mon, 28 Sep 2020 22:37:17 +0800
Message-ID: <CA+PpKPkAmnVhkwgZU84udJ0BEi+Pd4UOBaJJDVmvd+P=Depbng@mail.gmail.com>
Subject: Can we remove the checking of CONFIG_ARCH_HAS_PTE_SPECIAL in __vm_insert_mixed?
To:     npiggin@gmail.com
Cc:     dan.j.wiilliams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the previous email is corrupted. This is a resending.

In the current code, if the architecture supports PTE_SPECIAL,
__vm_insert_mixed() becomes a simple encapsulation of insert_pfn()
because it always calls insert_pfn() and never calls insert_page(). This
behavior is inconsistent with the function's name. As described in commit
423bad600443 ("mm: add vm_insert_mixed"), this function is designed to
supports _both_ raw pfns and pfns with struct page, but in architecture
with PTE_SPECIAL, it treats the latter as the former. So, I think we'd
better remove the checking of CONFIG_ARCH_HAS_PTE_SPECIAL to make the
behavior consistent for all architectures. If my understanding is right,
I can submit a patch to fix this. Thanks.

Regards,
Hao Lee
