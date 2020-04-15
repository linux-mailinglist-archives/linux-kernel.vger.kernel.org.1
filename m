Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7CE1AA169
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369955AbgDOMkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 08:40:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60763 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369929AbgDOMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:38:41 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jOhJP-0004fN-PA; Wed, 15 Apr 2020 12:38:39 +0000
Date:   Wed, 15 Apr 2020 14:38:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: add build-time CLONE_ARGS_SIZE_VER* validity
 checks
Message-ID: <20200415123839.hgcpabksyxmq5thz@wittgenstein>
References: <20200412202658.GA31499@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412202658.GA31499@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:26:58PM +0200, Eugene Syromiatnikov wrote:
> CLONE_ARGS_SIZE_VER* macros are defined explicitly and not via
> the offsets of the relevant struct clone_args fields, which makes
> it rather error-prone, so it probably makes sense to add some
> compile-time checks for them (including the one that breaks
> on struct clone_args extension as a reminder to add a relevant
> size macro and a similar check).  Function copy_clone_args_from_user
> seems to be a good place for such checks.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
