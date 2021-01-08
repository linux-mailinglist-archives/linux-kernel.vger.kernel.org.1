Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C402EF117
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAHLLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:11:11 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51339 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbhAHLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:11:10 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D59971AD2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 06:10:24 -0500 (EST)
Received: from imap6 ([10.202.2.56])
  by compute2.internal (MEProxy); Fri, 08 Jan 2021 06:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=awxeo4GTIfDddgqljasaQcdCXWQGMfj8+WQBFFo7+TY=; b=ACHhbB/6
        CKrMVNZZkSM1paCxbVFRWSIXr0HoTeyjy7v17sJSxNV6Qkr4QY2wJrxWLBNKeOp0
        mbSTOcNWqWFEVgXwG0UPZKQjAPGoA3tTBP5VVCVKjo1oepa2qEZ8uIf/cokenxHN
        Yq1yuyoWpsKqE9E2xsmnjQA49AL5UzFfBPhWabL/9/xKolqq0D1qVCcnAkFtRVLK
        GH5d2RJzTRmcAyAn64tYVoKleNqqRfz8+FnhMDsNNpYLEH1z0eYnfUmSj3SM3aXd
        iwwtC8IsxAYEG4DQBTKCN1vZwmkMRXs0z3maGJVXrBJL/pGzTOMNGtpv87P1QFrX
        /kaLhfAWwmr2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=awxeo4GTIfDddgqljasaQcdCXWQGM
        fj8+WQBFFo7+TY=; b=M+VTNoX/ENnrgkCgZ7yyBENbTuPh4F838k8BWcr9GeTSa
        8mwDEXLGeMfOQv7Nq25xg5BFHBRml26edMzcliCO6z+VJ9JP+B5dyLKT7vad/0Bt
        HIQvwpgedZA8iw71COjGyrmo37QPzIV3fKEWEbeX5XExB08RJ0bKqweWmom1G1/W
        P26xo/GcDqFe66YVh60QgFxNlSCvMgqRP2lawhdcSEj+QT2v3hfykAl8NibHGjL7
        nigbwx8VnMm9eiCqkgcVKGdyCnTm3lYOqhBZveh878VpzTnL/IzrldR8rdK5coNJ
        nGqlGpN4Q32FL38kI2r1fKcmC6Oga+qpO3K+OX+kw==
X-ME-Sender: <xms:oD34X9aoNH5BgXqaFFz4C5Z_5rxdbFfjInRW6AV3GwTNVXL6Wiz1YA>
    <xme:oD34X0ZDWo2R7x2MsFugSRZSnvZyDP39DKPu2kq-jlaE_SAXlEzRsqSYLTVN8QmPt
    SNBlI2fOemGSOrRNyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcuhghilhhlihgrmhcuufhnohif
    hhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqnecuggftrfgrthhtvghrnh
    epleduvddtteduhedvuefhhfehkeetlefhjeefvddtffdugfeikedtueetgeffgfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhish
    eskhhouggvheegrdhnvght
X-ME-Proxy: <xmx:oD34X__gx_dgkoc1Z0aRH5Uph5oiki1az27rMk3DwPc6EBeWP9-d3A>
    <xmx:oD34X7pSN-a619e8HsVSxghnmAdVaiD7w9iesRdssORa2KyOqU07Ug>
    <xmx:oD34X4oZnYWBIccsORdmb5b9mEFHCrvMNju3_3E9blQjnI8UBOApXA>
    <xmx:oD34X10Y5dY6DvJyWLPDBJ5DNAIe9Si-YBi85VAaTaiuGp19_ZWJ3A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 969931400A1; Fri,  8 Jan 2021 06:10:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
Message-Id: <90b1b5c8-36d5-4094-add4-3a2d211085c2@www.fastmail.com>
Date:   Fri, 08 Jan 2021 03:10:03 -0800
From:   "Christopher William Snowhill" <chris@kode54.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: Linux 5.11-rc2
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a regression with the filesystem NLS modules. I cannot load any of them. They all produce:

modprobe: ERROR: could not insert 'nls_cp437': Invalid argument

The system journal reports:

Jan 08 02:04:56 mrgency kernel: BPF:No data
Jan 08 02:04:56 mrgency kernel: failed to validate module [nls_cp437] BTF: -22

As a result, I cannot mount vfat filesystems with the usual CP437 default. Or any other code page, for that matter.
