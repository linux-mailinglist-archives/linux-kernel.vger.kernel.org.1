Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE12EB6BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAFAMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:12:54 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:6493 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAFAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:12:53 -0500
Received: from thorin.petrovitsch.priv.at (80-110-119-204.cgn.dynamic.surfer.at [80.110.119.204])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 1060BkFT016250
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 6 Jan 2021 01:11:47 +0100
Message-ID: <fd1f185337954ffc9f21a49f944909f10f8baf48.camel@petrovitsch.priv.at>
Subject: Re: in_compat_syscall() on x86
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
Date:   Wed, 06 Jan 2021 01:11:45 +0100
In-Reply-To: <878s97aq4c.fsf@x220.int.ebiederm.org>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
         <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
         <87mtxodxat.fsf@x220.int.ebiederm.org>
         <20210105005700.GR3579531@ZenIV.linux.org.uk>
         <878s97aq4c.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.tuxoid.at 1102; Body=7 Fuz1=7 Fuz2=7
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.1
X-Spam-Report: *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
        *  0.1 AWL AWL: Adjusted score from AWL reputation of From: address
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on esgaroth.tuxoid.at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Tue, 2021-01-05 at 18:03 -0600, Eric W. Biederman wrote:
[...]
> Maybe I am wrong and there are interesting users of x32.  All I remember
> is that last time this was discussed someone found a distro that
> actually shipped an x32 build to users.  Which was just enough users to

https://wiki.debian.org/X32Port ?

[...]

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
There is no cloud, just other people computers. - FSFE
                     LUGA : http://www.luga.at


