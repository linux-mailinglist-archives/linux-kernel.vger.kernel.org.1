Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720CD2FE4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbhAUIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbhAUIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:06:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEFC061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:05:27 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2Uxg-009TPT-CG; Thu, 21 Jan 2021 09:05:00 +0100
Message-ID: <a60c9b90b5db4dbc40ad9cf8c0cfadc01bd4fd2c.camel@sipsolutions.net>
Subject: Re: Splicing to/from a tty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu, 21 Jan 2021 09:04:55 +0100
In-Reply-To: <20210121060522.GA23430@1wt.eu>
References: <20210118195400.GC736435@zeniv-ca>
         <20210120162608.GB740243@zeniv-ca> <20210120191116.GC740243@zeniv-ca>
         <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
         <20210120231439.GE740243@zeniv-ca>
         <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
         <20210121003835.GF740243@zeniv-ca>
         <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
         <20210121014528.GG740243@zeniv-ca>
         <CAHk-=whqZbEPt2WC6WRWrMNPqaTsx99dp74vB6FQfM4aO6biQQ@mail.gmail.com>
         <20210121060522.GA23430@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-21 at 07:05 +0100, Willy Tarreau wrote:

> I think that most users of splice() on sockets got used to falling back
> to recv/send on splice failure due to various cases not being supported
> historically (UNIX family sockets immediately come to my mind but I seem
> to remember other combinations).

Note, however, that I got here because cgit, if using sendfile(), does
*not* fall back if it fails (and thus my git tree view is currently down
because I haven't downgraded the kernel so far). That may not be common
for splice() though.

johannes

