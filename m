Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD432BC6F9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgKVQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 11:28:53 -0500
Received: from devianza.investici.org ([198.167.222.108]:22957 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgKVQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 11:28:52 -0500
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4CfG1t72h3z6vQK;
        Sun, 22 Nov 2020 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=privacyrequired.com;
        s=stigmate; t=1606062530;
        bh=XproVJPgCihpyQsL8MURq6gVaqDJXUK82PEKk0zVgWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhzUIQDj5fnGi1VFRi7qHBPHMXeWd63sjAO/ogsKKi7ez8IezHZPAwlYS0j7PzYck
         VE4r3SQgvlCGB2UVQ9W3PEhdRaLr+h7tfg69ryh0crQN60WzEQAe4GC8ANlAld1/5O
         QKJ0enFzuaQSMoo4uaLPQgQQU8IanYbfYlBBSdJM=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: laniel_francis@privacyrequired.com) by localhost (Postfix) with ESMTPSA id 4CfG1t4NVdz6vQH;
        Sun, 22 Nov 2020 16:28:50 +0000 (UTC)
From:   Francis Laniel <laniel_francis@privacyrequired.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Date:   Sun, 22 Nov 2020 17:28:44 +0100
Message-ID: <4487519.2G65qjV9lv@machine>
In-Reply-To: <202011201150.AE57F56EB@keescook>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com> <5676804.6kI0aEeX2c@machine> <202011201150.AE57F56EB@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 20 novembre 2020, 20:52:07 CET Kees Cook a =E9crit :
> On Fri, Nov 20, 2020 at 10:40:38AM +0100, Francis Laniel wrote:
> > Le vendredi 20 novembre 2020, 02:35:43 CET Andrew Morton a =E9crit :
> > > On Thu, 19 Nov 2020 17:49:10 +0100 laniel_francis@privacyrequired.com=
=20
wrote:
> > > > This patch set answers to this issue:
> > > > https://github.com/KSPP/linux/issues/46
> > >=20
> > > I fail to understand what this patchset has to do with that
> > > one-element-array issue :(
> >=20
> > I think I linked another issue totally not related with that one...
>=20
> This just looks like a typo. The URL should be:
> https://github.com/KSPP/linux/issues/96

This is not a typo because my branch to work on this issue is called 46-
fortifiy_strscpy.
I just think I got mixed up!

But I completely removed the link to this issue in the v7, so it does not=20
matter a lot now.


