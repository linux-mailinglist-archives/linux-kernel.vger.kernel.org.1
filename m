Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DECE2F0601
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAJIiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:38:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:49369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbhAJIiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610267754;
        bh=AYGpEcijaxGgdxbHWEgk3QAzVtE4/IoirszuB5L1Bg8=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=NLVbQKG+bN4Ab6kgHvSTJhNmmD6otHEk+C2OaUQv6VmltDkud/gIWgNPb6X7skMRS
         pInDmCIm76nvQORNgRawWFUAhXKhvgAfHA+nAXqJ3Z0RurXD6FaFDxnMmsJA/8LAqJ
         g9BxEfkFA6/v2gNNtYh5nFr9SW915NrvFoSrXvwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([80.208.211.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1ju8AT26vT-0155dp; Sun, 10
 Jan 2021 09:35:54 +0100
Date:   Sun, 10 Jan 2021 09:35:46 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20210109190937.42409-1-linux@fw-web.de>
References: <20210109190937.42409-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dts64: mt7622: fix slow sd card access
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>
CC:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Wenbin.Mei@mediatek.com, sin_wenjiehu <sin_wenjiehu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jimin Wang <jimin.wang@mediatek.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <059279A9-8530-41AB-9997-04B2D22BB11B@public-files.de>
X-Provags-ID: V03:K1:K7/234lirOc+CxkHbj/O/PQPi9gMldKz2CdoGZCHu/nKXvcwLkl
 /EyLYvTxEmDgvO1BI9AiWIPmPVPqzAGIBRlPKDJuzrHceT2YUrG+VLm90SsZjp/1AfnA9xG
 KmSphA73sAc4MuMo+/B9ee8C4o9m8ORoNa2O2xACMfrOjArUtLD4iqPEHpw2B9ADnK2xLYo
 eDaJtWzGbe6GkGVA0TUiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXg5R0fSKYU=:PhAQb/VURv9Qd6VcAQG3eR
 X9P+X4bJdTsSJxO7v/0gVGgiJExZVHLaVr0S1CnXkB74WN+qJtbQRs+xcsdZw4Img0pyQ0KEj
 vGjej3oVjtIaRlRmg/e5imcvsLgvDT5Im/npPJl+XxZ621g4V6sSbgXAQREFMm4SRARwc7IJ0
 poRRx8zZSCoLBh5NqYwlQzteAXfyGg8aVzmC7/nU29Qj6jnZnaV/hbNngn0sU62f0Esqeqtdn
 kR5W8WY7G5xHd+C442nfwqLUKoQIL3zNA5q2EK/BDoiNSU2CUOPTStH6dKOpRN/aaSG7f6jHP
 7+0oSxIlqIWWUnECVOFlJ6WaMWSizgYu4BvJqaxclioYY0Y9e4/Xn8fQ5LOAE0bLS2+VRAUPX
 0o+gSumt1IAlx89VtsIKDcr0xfcZG33w45qUMpq2WNRMIq5F+tuVLU5BVquFZZYVCmHM7sqzM
 NFs2GLFN/owfekiCpzPWo3/PycY8APa2dVHcz4e16NHkXk0UOZJWWhjBnN5pfDt+x+KrMFCqa
 eVr8jblw2cxxlhSQj2EkaReHh2/ndM9cAEBNIiU/YMrFA/VCz/Lpt2/HrNRiR2uM3oR5Cia78
 eBQDooEvnsFJwcBuZqM2MCqO+TC3B5AGZuJWlXF5oE+lJVsaCHeaQpJ+ngRcefK7+9BmHW6Qd
 GYQxRZu0KtIzo73feLbFjMMN9ezcRjrVuo4h2hZlj4oKf3a+nlAzxbUZpTwJcqGS+sLEicZXi
 XpJMgnwzB1qsN3m8+ay0t1nP5TG1Az43vs2uSCLJNSeyn2DrX7iXGIWin8Dq8x+gfZnRfRC1y
 XOACaU3I7TMRW2TFitnJqU0AjAHcl8bpBBigGDCt2iTJbLKDKM9LHt8FbjwyhRyAsF7EgVy1Z
 PR41u3dEmU9GjmZysfzw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess issue is caused by incompatible setting in uboot,but have not found=
 which exactly so i handled it like emmc=2E

If patch is ready to be applied please add=20

Cc: stable@vger=2Ekernel=2Eorg

because all kernel versions are affected (tested at least in 5=2E4 and 5=
=2E9)=2E If i need to create a v2,i will add it

@sean/ryder/wenbin can you tell me if sd on mt7622/bpi-r64 is maybe capabl=
e of hs400?
regards Frank
