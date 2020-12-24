Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3C2E2321
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgLXBGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 20:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgLXBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 20:06:31 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5539C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 17:05:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4D1X2320TZz9sWX;
        Thu, 24 Dec 2020 12:05:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1608771947;
        bh=CL3AnHOz06mrGbhgw6tM4Noc2JcCqYwI4iu0BsEovkk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fCiucknv8nL9x1/qU3U+wOdvGZCd6NIyqFGZNxwe605kmn9m1Y3iU8lFekIv/MbRs
         KgGzk4os0Uj70EK6ulPJd7VEB/AQ69hubpSEAJWOObpUa+6aAr8XTjyTuCebWT+IIR
         1g+Ah5eczZ3TvJu6EGtfjazPe1waUuPVZPr8SspE4WzGXxMPdhuQQX8ZRBIWqsnBGL
         3Mhqes70K5LsI366MyIQYkfrqbSmj6PeBXXCvXVqiNumGlNbB3PTUm1yZbVPNfNdKl
         AyX6R+0tuTJR2sjq+JBZYo0LwVWw45rFcAHo6DWSkwpktYqfyRM0rwBuTt7TEE6/B5
         U7zEYoB7AsUNg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack
In-Reply-To: <6ed0b74d-8d01-4a20-faed-891496fb77b4@csgroup.eu>
References: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu> <6ed0b74d-8d01-4a20-faed-891496fb77b4@csgroup.eu>
Date:   Thu, 24 Dec 2020 12:05:43 +1100
Message-ID: <87im8s6mjc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 22/12/2020 =C3=A0 08:11, Christophe Leroy a =C3=A9crit=C2=A0:
>> When we have VMAP stack, exception prolog 1 sets r1, not r11.
>
> But exception prolog 1 uses r1 to setup r1 when machine check happens in =
kernel.
> So r1 must be restored when the branch is not taken. See subsequent patch=
 I just sent out.

OK. This is still on the tip of fixes, so I'll rewind it to drop this
commit, and then apply this and the fixup as one patch next week.

cheers
