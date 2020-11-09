Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2313D2ABCC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgKINkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbgKINkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:40:45 -0500
Received: from linux-8ccs.fritz.box (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B58206CB;
        Mon,  9 Nov 2020 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604929244;
        bh=+VdWaxHs53uvHZ4NxwqLvFRNZhIN+FlD0P6Qe12XBLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHmRwpRfWj1GCfp4m6XlHgP72EKV+XCxsn8k1IKyIayfoky+JcDXfmV/oMIj7Urnq
         iJY1x+nlspn+KmDTqN6Nyh9RUVFZLXlsYWJj1PRj2tzW+LkAAodZdyOdrW4T2UZidV
         uC/eje6XrGRRmRb4qVrg82uNbDSxavVBAoRABO0k=
Date:   Mon, 9 Nov 2020 14:40:39 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: fix comment style
Message-ID: <20201109134036.GB24810@linux-8ccs.fritz.box>
References: <7cabd5fd-e413-9b71-004e-56c9c329de23@omprussia.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7cabd5fd-e413-9b71-004e-56c9c329de23@omprussia.ru>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Sergey Shtylyov [07/11/20 23:20 +0300]:
>Many comments in this module do not comply with the preferred multi-line
>comment style as reported by 'scripts/checkpatch.pl':
>
>WARNING: Block comments use * on subsequent lines
>WARNING: Block comments use a trailing */ on a separate line
>
>Fix those comments, along with (unreported for some reason?) the starts
>of the multi-line comments not being /* on their own line...
>
>Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
>
>---
>This patch is against the 'modules-next' branch of Jessica Yu's 'linux.git'
>repo plus my 2 patches posted this week.
>I'm not sure such patches are welcome, please let me know if they're not...
>
>Changes in version 2:
>- fixed up the comment before find_symbol().

Applied, thanks for the comment cleanups!

Jessica
