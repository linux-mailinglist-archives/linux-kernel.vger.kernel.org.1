Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B702C88E5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgK3QEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:04:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgK3QEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:04:10 -0500
Date:   Mon, 30 Nov 2020 17:03:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606752208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ejan0ZhOEyu24ceXv5BOSGhFsREBbTH/zgUcOvbllg4=;
        b=FSVymrrDth2W0Dp+JPGfOwSJA9g4kbVoicUl59VyXLLMIvLS0eRBDlABMCoKDTsOM08HFe
        OFy4dsAqyBy9mHWwkSBLrL1Bzs/HHhQ8M2eDiTdRdhb15kcqzO3rjq6IehHS0mL/MrZSa2
        oQxRTpuV8vHLQUyAdRfswC5ExlgCwmRYy322dcO/rMO5Iyg3sjJ7ZwzoAdMyqaJm7IkxFX
        IoX2ThEj3aOLeU9F8Qeob4hJQDdj1Qj76QsCIqxs4flXV+u0d974lfaHN4hl6o8GqZR6pZ
        FmrVjx69snzK2PQQa+BkTijNAMGhztuDEx/CIDgcKBbeG7rj6HO4SC9p3i4hTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606752208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ejan0ZhOEyu24ceXv5BOSGhFsREBbTH/zgUcOvbllg4=;
        b=xnIkAsom+XVLu1yiw07BqQZp4yZKX5MEpF9EqzS/lUBexaGmk+YvJIGbFF7QwZNevTEOfI
        kgv8EdBiamEVYYCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130160327.ov32m4rapk4h432a@linutronix.de>
References: <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
 <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-30 16:01:11 [+0100], Mike Galbraith wrote:
> On Mon, 2020-11-30 at 15:52 +0100, Sebastian Andrzej Siewior wrote:
> > How do you test this? I triggered a few oom-killer and I have here git
> > gc running for a few hours now=E2=80=A6 Everything is fine.
>=20
> In an LTP install, ./runltp -f mm.  Shortly after box starts swapping
> insanely, it explodes quite reliably here with either z3fold or
> zsmalloc.. but not with zbud.

This just passed. It however killed my git-gc task which wasn't done.
Let me try tomorrow with your config.

> 	-Mike

Sebastian
