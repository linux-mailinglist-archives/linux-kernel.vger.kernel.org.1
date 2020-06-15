Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236B31F9817
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgFONQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 09:16:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:30956 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgFONQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1592226989;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zqxmVgdmjcOl7HZi58VyJB7Dsh33gu503wdQu+OOuvI=;
        b=PYRP3IWJeVC0k8GcSwZWnnL2k/7V1/H/CkXXuoY2ldq1bLIepW6O9o2CHvdtbw8suo
        9dgBnSp6aIZzH+JAjGFk9vg1iImYNMPA71taWZ0sT/wrYcJjf8AI505YnOQj33PlLX+R
        jMxFe8ml9Csm9zGguDFc6ZYqP+L8Iee7VI3pg6avK0lc1IfSUvTc5pXKnNC8ac2ClK8t
        cTUxHNcMSnPKYYnJWeeix2hM3DfBaQ1yZzdlgKyntfIX05kBKC9q1d7jyrZrClAvh1Rf
        EwTE4avkGwilvJjPIDDWwgfIadZg941fcqD/YmBkniY8M6sL/sxcBI59Twnv9PtpdI1X
        hdOQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJfSc9CNS"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.4 DYNA|AUTH)
        with ESMTPSA id U03fedw5FDGPB5E
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 15 Jun 2020 15:16:25 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 13/14] crypto: sun8i-ce: Add support for the PRNG
Date:   Mon, 15 Jun 2020 15:16:25 +0200
Message-ID: <2861786.iSnlG1rnU6@tauon.chronox.de>
In-Reply-To: <20200615130253.GA8958@Red>
References: <1587736934-22801-1-git-send-email-clabbe@baylibre.com> <5634597.9v007L4FOH@tauon.chronox.de> <20200615130253.GA8958@Red>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Juni 2020, 15:02:53 CEST schrieb LABBE Corentin:

Hi,


> I still dont see any memset_secure in kzfree (mm/slab_common.c).
> Does I miss something ?

Nope, you do not miss anything, it seems that the patch that I had seen did 
not go in.
> 
> Regards


Ciao
Stephan


