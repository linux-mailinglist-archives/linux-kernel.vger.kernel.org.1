Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBC218B46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgGHPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:32:16 -0400
Received: from mx.exactcode.de ([144.76.154.42]:51766 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgGHPcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:32:15 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 11:32:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:Cc:Date:Message-Id:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From; bh=S3lEPG+1EXEM+7Jm0p1Z3VqZnk08s6ZmQH43mmkofC8=;
        b=DkzdcEvePzVMBtaSDO+vH4YKHBuH6v2Gr83K8IYqWKIJ/NyIKna+zwu0k4i1eNR+KAta6XCKiqs4Qrr+FXAHoSLph6ekz9TrSV/30DHET8Y9h76iCHDGPMp8maqTB/JoYvqgClK9otbkNIsBy19aEv2BRrwYk40+/rEHydXZ0aM=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1jtBoW-0004gM-SN; Wed, 08 Jul 2020 15:16:49 +0000
Received: from [192.168.2.174]
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1jtBqm-0000Zo-AL; Wed, 08 Jul 2020 15:19:08 +0000
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Vectored syscalls Was: [PATCH 0/3] readfile(2): a new syscall to make
 open/read/close faster
Message-Id: <3ADE6606-6572-4D7D-BB8F-9286B368DF93@exactcode.com>
Date:   Wed, 8 Jul 2020 17:16:41 +0200
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        viro@zeniv.linux.org
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Score: -3.1 (---)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

maybe instead of this rather specific, niche readfile syscall, would it =
not be beneficial
to allow issuing any group or bundle of several arbitrary system calls =
so this could also
be used to speed up other, more demanding high performance applications =
that need
a bit more than just readfile()?

An iImplementation could use some SYSCALLV syscall taking some io_uring =
like
structure with a list of flags, syscalls and arguments, so that this =
case could be submitted
as something like (illustration purposes only):

{
	{ABORT_ON_ERROR, OPEN, =E2=80=A6},
	{RET_TO_ARG1, READ, =E2=80=A6},
	{0, CLOSE, =E2=80=A6},
}

I hope that sounds useful,
	Ren=C3=A9 Rebe

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, =
https://exactcode.com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | =
https://rene.rebe.de

