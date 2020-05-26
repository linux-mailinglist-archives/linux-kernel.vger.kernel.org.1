Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91BFA1A60AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgDLVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgDLVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:13:42 -0400
Received: from youngberry.canonical.com (youngberry.canonical.com [91.189.89.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80EC0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:13:42 -0700 (PDT)
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNjvB-0005jJ-JW; Sun, 12 Apr 2020 21:13:41 +0000
Date:   Sun, 12 Apr 2020 23:13:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: add a check for the user struct size if
 CLONE_INTO_CGROUP is set
Message-ID: <20200412211340.lckgq6olfrga56ql@wittgenstein>
References: <20200412203123.GA5869@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412203123.GA5869@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:31:23PM +0200, Eugene Syromiatnikov wrote:
> Passing CLONE_INTO_CGROUP with an under-sized structure (that doesn't
> properly contain cgroup field) seems like garbage input, especially
> considering the fact that fd 0 is a valid descriptor.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Thanks, will queue for rc2 unless I hear objections.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
