Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D31CA800
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHKNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 06:13:55 -0400
Received: from ozlabs.org ([203.11.71.1]:33175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgEHKNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:13:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JR4b4g6Nz9sRf;
        Fri,  8 May 2020 20:13:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1588932832; bh=eCsSRJac38GrK7EJdAunFBqxque6vOn9w3DPcafz3R8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=miPMYgFoekg62ODTyI9JNEJp2uOCmzjkR6ys1sNheups67c8l+BE5tDou9TYtUQwb
         zflbxzwtf1iZtSD4CE9+TrrctGVqWas4ktFTzeUn/exEfXyVHHGmEVKYyD4FJAIkUo
         U2TaxLMUn2zxY7i8wzoiFs3DAa4QM3deWqrKYS1p/x/jenOqF2xtR7MXHFh1xOOO7Y
         Q584B/BxsxF83t4Akn57ebL5U2nt5FCV9EIEJrkWFKJaIfbexZmX2exIy0SKnSvElt
         arDPDzKYi1feq4f7XshEXweejBRMYXthElqi3MjnSIrmxueO9Zog7UJUOQtpnPlrxx
         xT6JgawC4/qWQ==
Message-ID: <4c9cc9184213ded65489cb95050046c8904ddad8.camel@ozlabs.org>
Subject: Re: [PATCH] powerpc/spufs: adjust list element pointer type
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Date:   Fri, 08 May 2020 18:13:46 +0800
In-Reply-To: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
References: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

> Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
> that the list elements have type spu_context, not spu as used here.  Change
> the type of tmp accordingly.

Looks good to me; we could even use ctx there, rather than the separate
tmp variable.

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

