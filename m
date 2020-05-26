Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313961B2456
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgDUKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 06:50:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53427 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgDUKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:52 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQqU1-0003mW-0u; Tue, 21 Apr 2020 10:50:29 +0000
Date:   Tue, 21 Apr 2020 12:50:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in
 __task_pid_nr_ns()
Message-ID: <20200421105028.fihn4kczt6pqzfdr@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421090426.GA6787@redhat.com>
 <20200421101904.GA9358@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421101904.GA9358@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:19:04PM +0200, Oleg Nesterov wrote:
> Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
> from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
> task->group_leader, we can remove the pid_alive() check.
> 
> pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
> unnecessary confusion.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
