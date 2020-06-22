Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22732203321
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFVJRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgFVJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:17:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:17:55 -0700 (PDT)
Received: from [10.165.156.120] (unknown [46.114.36.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 744AE1EC01A9;
        Mon, 22 Jun 2020 11:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592817473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLYpfA9gJJLVtCyFJRgSaTXP2FEh/u2O/iupib54I+M=;
        b=SVDBqNAB4jU85ahM9o8+QsB6vLSEhQUiWtOq2Tkn4X2u91YeEErqYIYccpX3qrNFR3Rvs+
        hBW1sd+cUPFCDL/YUrVhX3xiKF8XoaQ5TWEoLE1hXqiLFkIFcB7kvwH556k0fAJaG0whrZ
        3iQfeWRjSr6S4hViuGsiu1fS95m39eg=
Date:   Mon, 22 Jun 2020 11:17:51 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <4d1ef78e-f001-a685-9a69-afa68454fdc7@oracle.com>
References: <20200621102634.n43ozcsiravdi2ie@debian.debian-2> <4d1ef78e-f001-a685-9a69-afa68454fdc7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] arch/x86: Return value from notify_die should to be checked.
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Bo YU <tsu.yubo@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, peterz@infradead.org,
        luto@kernel.org, jannh@google.com, dave.hansen@linux.intel.com
CC:     linux-kernel@vger.kernel.org
From:   Boris Petkov <bp@alien8.de>
Message-ID: <6CFD253C-824B-4F95-BBB0-F53123DBC323@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 22, 2020 10:52:23 AM GMT+02:00, Alexandre Chartre <alexandre=2Echar=
tre@oracle=2Ecom> wrote:
> So the appropriate change to make Coverity happy=20

Or we can stop "fixing" the kernel in order to shut up tools and not do an=
ything=2E


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
