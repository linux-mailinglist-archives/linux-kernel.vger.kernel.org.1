Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC16D2888F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbgJIMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:39:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58371 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:39:42 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQrgN-00089z-1h; Fri, 09 Oct 2020 12:39:35 +0000
Date:   Fri, 9 Oct 2020 14:39:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, keescook@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] drivers/android/binder: convert stats,
 transaction_log to counter_atomic32
Message-ID: <20201009123934.4524t6rj6pa4wd7z@wittgenstein>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <63482420f221c3483f6526bfc12fc99fe30a567d.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63482420f221c3483f6526bfc12fc99fe30a567d.1602011710.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 02:44:38PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> stats tracks per-process binder statistics. Unsure if there is a chance
> of this overflowing, other than stats getting reset to 0. Convert it to
> use counter_atomic.
> 
> binder_transaction_log:cur is used to keep track of the current log entry
> location. Overflow is handled in the code. Since it is used as a
> counter, convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---

Thanks!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
