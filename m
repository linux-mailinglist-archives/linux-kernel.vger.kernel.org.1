Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB0E1A291D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgDHTIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:08:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46882 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgDHTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:08:13 -0400
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jMG3W-0001ui-Db; Wed, 08 Apr 2020 19:08:10 +0000
Date:   Wed, 8 Apr 2020 21:08:09 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: android: binderfs: add 'stats' mount
 option
Message-ID: <20200408190809.eb4znnjjhdaycmep@wittgenstein>
References: <baa0aa81-007d-af46-16a5-91fead0bd1b9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baa0aa81-007d-af46-16a5-91fead0bd1b9@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:29:50AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add documentation of the binderfs 'stats' mount option.
> 
> Description taken from the commit message.
> 
> Fixes: f00834518ed3 ("binder: add a mount option to show global stats")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devel@driverdev.osuosl.org

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
