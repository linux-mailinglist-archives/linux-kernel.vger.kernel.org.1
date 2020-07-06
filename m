Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1357C215273
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 08:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgGFGPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 02:15:46 -0400
Received: from mout.web.de ([212.227.17.11]:46553 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgGFGPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 02:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594016110;
        bh=GnXk+Khqcb9KVAHtOYkeaYBiriaNRUM1boZT8Oubj6w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RqgFFIuQMN/dCQaIsEGTvHWiO84SAc9QB//7hKQJibFWqsnJ+s0zryg2pFxuOVLpg
         lB5KwJJEyzOIH4xi40M1a2EVDQtkI4OMhs5lLEDKH/8Mkk3HVJHwgkvFV1RGUO8R4J
         f+x6hOXsNV2pZ8YnEuS4gk6ip9jjt0Nr8njHxRPc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpezi-1kWMWW2n3e-00fRX7; Mon, 06
 Jul 2020 08:15:10 +0200
Subject: Re: [PATCH v5 03/14] irqchip/csky-mpintc: Fix potential resource
 leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Denis Efremov <efremov@linux.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
 <1593998365-25910-4-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3cdb3f12-0862-6985-2236-a724267ead81@web.de>
Date:   Mon, 6 Jul 2020 08:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593998365-25910-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWklsLbtcH8+/xjKLRaQjV0eW+fJ88gQ0wL1vmljj+NkrBh7pJ1
 j8LMrpRBwENtVNY5WI4toUq50KXy1sj9PyLEqyIV0ZQpw0Xp+3fHsqKuwo/BvlRH0BZWo4G
 B5lMAMQuYyaEhTtMFmmW1Dr7RTbJkgcvOtuFyx1k+y9UmK4EaTlYpv+dKJRIllU4d/HF+tg
 /d8ThdQnKiqKkqHIhSWxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g4Wi0FAAJtY=:9JZJavhOuhLEeuxGrwJxU6
 Z0YQEIwBGmhf90BA5xrCbefqNRe8uieLj2t36jd/hkSOI4rTK0LX0XOZC8ZfOJCA/3gREUG0K
 7GU5Dbe0/om3sQQcdJcDL6Jc8GjPQWMgVwSi5LbJblW0fw0tKP6tcbkDi3oawlQeeQBA7/Mw0
 UMq+VH1qjwKvp2PmlfQgG/SnYWiLi706EZrCfxBXq36TGWO3gLmNYiipj1ClS8MBeDol65v3X
 OC3PbcjFQ1guQQUp7XWTR7ZKSl9Cbp//6O+bjuCozQ+VUKkbhNtVsG6YVKSXNkFbxHsw7i0pp
 VdWvO7+/uiOs7vsZmHe3DGcgJ6D0xRE5fTr7vKPizslpKeJ80Creo3W8bU+ryXHmPtnzeCjbp
 EVyhdabnFKBRyI6BR3RWQ2UYe7nGxNOz3eecj0lKGrvwLYuA5nB79awAaElIeZGHF/4maDUDO
 bkLfRW0Bjeq5EuDLLkIpkFywAoxQU3jLiwfHEcQmfI2TKs5lAvT1pUL5pncaD61fDufquNnsF
 voHrLOn2AL9TyXdKSkbEMGtWBPugddOToaDx7iZSkDT3hyOVFjUEBlg5ftuIPqtv1xfe+V4xs
 STz6vgY4X9EsI0IGdZ6SZf/IaVgpwwI7L6pcG99uweum7nkhO/xAj3K6mWk92elRXUQcG5+p8
 0NB7uHx3Qcq2E1r8dj0Hcs6L1TIGEdeAqRiOAn8hvL83RyAz/FDFlZYilalH5AWP/0kJLI1k9
 TZuyRHM4K7WMh14YwPOPHN6EKryI+bMJgh3Nb7jWN94BX8WMJDs2xZBT4s1A+yjjOLDu7Cg2T
 d1/dv1GQwyetX6R83DXFp5cqQL2WVYujfL6OzCo4JEihL+uZd0cG9+I7Ysf5Gf1b9cKf2GxZM
 TBBvFMDQrTxXbpNaXqrBs0jUmKP99XynWL8y2GU5JfuNXcgd8fbku5gHceDHk5Pqx0D8fHpSl
 JtSZIDkfvmj4YVBTMIARV8wRBditjgJgBAMlHZ4Gpnw3RrSYk4gf06L6A+uW4v+gj1lWMotd0
 +egJQliQF5bhLcqoxGowVCYF9izdRbDGPyCX8PKgwH6rcoR5xdQZVtoASPMN7HOXRsVQCb+8O
 Cnum1hkHh0pIG+u/BhZegDQZrYGWdFqOMgRewChHigpBLnS/Sgx6kG3Kfc2yf7FnKm35/AD+C
 NXbfZmbdX9RsJZWXD+EovA2O5NZW/X7Ogo7j2J0VxeOgLLHGSqTQb7ARD96/T6SvOC0vbf1xE
 Pr/ZWKO+I+5994Iy+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> =E2=80=A6 Thus add jump targets for the completion of the desired
> exception handling. By the way, do some coding-style cleanups
> suggested by Markus.

I propose to split these changes.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Ddcb7fd82c75ee2d6e6f9d8cc71=
c52519ed52e258#n138

Would you like to support easier back-porting of a fix
besides another bit of possible source code beautification?


=E2=80=A6
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -241,14 +241,16 @@ csky_mpintc_init(struct device_node *node, struct de=
vice_node *parent)
=E2=80=A6
 		INTCG_base =3D ioremap(mfcr("cr<31, 14>"),
-				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
=E2=80=A6
+				     INTCL_SIZE * nr_cpu_ids + INTCG_SIZE);

Can any macro (or function) be helpful for such a size computation?

Regards,
Markus
