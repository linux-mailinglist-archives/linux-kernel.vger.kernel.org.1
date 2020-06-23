Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354462066D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbgFWWCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 18:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgFWWCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:02:42 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94E7C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:02:42 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 6AEF55F87E;
        Wed, 24 Jun 2020 00:02:41 +0200 (CEST)
Date:   Tue, 23 Jun 2020 15:02:41 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
In-Reply-To: <20200623215042.GA43266@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.1.446.2006231456380.3892@trent.utfs.org>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org> <202006231131.AD0A7F5F@keescook> <alpine.DEB.2.22.1.446.2006231430280.3892@trent.utfs.org> <20200623215042.GA43266@localhost.localdomain>
User-Agent: Alpine 2.22.1 (DEB 446 2020-06-13)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Alexey Dobriyan wrote:
> BTW this bug was exactly the one described in the changelog:
> compiling assembly brings executable stack by default:

Great, thanks for the pointer, will wait until this lands in Arch. My 
search engine brought up the lkml discussion though, no the thread[0] on 
rsync-cvs ;-)

Christian.

[0] https://lists.samba.org/archive/rsync-cvs/2020-June/007661.html
-- 
BOFH excuse #211:

Lightning strikes.
