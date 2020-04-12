Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F008D1A609A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgDLVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgDLVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 17:00:07 -0400
Received: from youngberry.canonical.com (youngberry.canonical.com [91.189.89.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF279C0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 14:00:07 -0700 (PDT)
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNjhs-0004yT-CE; Sun, 12 Apr 2020 20:59:56 +0000
Date:   Sun, 12 Apr 2020 22:59:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org,
        akpm@linux-foundation.org, guro@fb.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
Message-ID: <20200412205955.acpwv5mfbbfxxtd2@wittgenstein>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:44:43AM +0800, Zhiqiang Liu wrote:
> 
> signal.c provides kill_proc_info, we can use it instead of kill_pid_info
> in kill_something_info func gracefully.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
