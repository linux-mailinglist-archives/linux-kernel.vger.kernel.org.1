Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3918E26AA16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgIOQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:49:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48059 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgIOQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:00:55 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kIDAe-00057M-PQ; Tue, 15 Sep 2020 15:47:04 +0000
Date:   Tue, 15 Sep 2020 17:47:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        ebiederm@xmission.com, christian@kellner.me, surenb@google.com,
        areber@redhat.com, shakeelb@google.com, cyphar@cyphar.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: Use helper function mapping_allow_writable() in
 dup_mmap()
Message-ID: <20200915154704.lvboxqqgfokbhidc@wittgenstein>
References: <20200913092415.24408-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200913092415.24408-1-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 05:24:15AM -0400, Miaohe Lin wrote:
> Use helper function mapping_allow_writable() to atomic_inc i_mmap_writable.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Hey Miaohe,

Thanks for the patch!
Per se there's nothing against using a proper helper when it exists.
But it has already been pointed out that this needs a proper commit
message with more rationale. But I'm otherwise happy to take this.

Thanks!
Christian
