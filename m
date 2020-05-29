Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E71E7799
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgE2IAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:00:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35376 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2IAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:00:31 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeZwJ-00041g-9k; Fri, 29 May 2020 08:00:27 +0000
Date:   Fri, 29 May 2020 10:00:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Robert Sesek <rsesek@google.com>, Chris Palmer <palmer@google.com>,
        Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 2/2] tests: test seccomp filter notifications
Message-ID: <20200529080026.hwuzcr6ah4egyszo@wittgenstein>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <20200528151412.265444-2-christian.brauner@ubuntu.com>
 <202005282240.B9AE912F6E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005282240.B9AE912F6E@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:41:45PM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 05:14:12PM +0200, Christian Brauner wrote:
> > This verifies we're correctly notified when a seccomp filter becomes
> > unused when a notifier is in use.
> 
> While you're adding this, can you adjust the other user_notif tests to
> check for POLLHUP as well (i.e fail if it appears)?

Sure can do. :)

Christian
