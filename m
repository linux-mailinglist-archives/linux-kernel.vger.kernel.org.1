Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6412EBFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhAFO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbhAFO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:58:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D7C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:58:01 -0800 (PST)
Received: from [10.161.252.158] (dynamic-046-114-036-158.46.114.pool.telefonica.de [46.114.36.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E99F1EC0249;
        Wed,  6 Jan 2021 15:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609945078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhyzaZmq1u6KDD6hxTkQWRpzWwnaYJXnStA6chzKJY4=;
        b=B53xflEwRBcGv1PynUSAppr3ENurG/J/5/adn1WhX2krU/le7InoFwHDIdhUyAsizD8kqO
        SmSUIqC1UgUepHV7mPhU/0z/gJ1inJz0w/cSBJCS87HFsxL+zTQCbNKWn040r2MzVaHoIz
        E5tqnR/fO2WKF7tqMw8jYpdsOLYX+zo=
Date:   Wed, 06 Jan 2021 15:57:55 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20210106144017.779081583@infradead.org>
References: <20210106143619.479313782@infradead.org> <20210106144017.779081583@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC][PATCH 6/6] x86/mce: Dont use noinstr for now
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <8B866DA6-ED68-4681-8D83-A23E8F18E77C@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 6, 2021 3:36:25 PM GMT+01:00, Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>Instead of using noinstr, kill instrumentation for all of mce/=2E This
>switches MCE over to a best-effort but non-validated mode=2E Doing
>better will require a significant investment of time and effort=2E

Another thing that we could do is carve out only the stuff which needs to =
be noinstr into a separate compilation unit and disable tracing only for th=
at while keeping the rest traceable=2E Need to try it to see how ugly it'll=
 get=2E=2E=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
