Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380082483B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRLQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:16:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40415 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRLP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:15:59 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7zak-0006Cd-IV; Tue, 18 Aug 2020 11:15:46 +0000
Date:   Tue, 18 Aug 2020 13:15:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] binderfs: make symbol 'binderfs_fs_parameters'
 static
Message-ID: <20200818111545.aq3iyhugs2luol52@wittgenstein>
References: <20200818112245.43891-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818112245.43891-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 07:22:45PM +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/android/binderfs.c:66:32: warning:
>  symbol 'binderfs_fs_parameters' was not declared. Should it be static?
> 
> This variable is not used outside of binderfs.c, so this commit
> marks it static.
> 
> Fixes: 095cf502b31e ("binderfs: port to new mount api")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
