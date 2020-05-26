Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632221D5823
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEORk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 13:40:56 -0400
Received: from ms.lwn.net ([45.79.88.28]:53508 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgEORkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:40:55 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9BE0672D;
        Fri, 15 May 2020 17:40:55 +0000 (UTC)
Date:   Fri, 15 May 2020 11:40:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] docs: acpi: fix old http link and improve document
 format
Message-ID: <20200515114054.2496c171@lwn.net>
In-Reply-To: <1588673836-9954-2-git-send-email-f.suligoi@asem.it>
References: <1588673836-9954-1-git-send-email-f.suligoi@asem.it>
        <1588673836-9954-2-git-send-email-f.suligoi@asem.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 12:17:16 +0200
Flavio Suligoi <f.suligoi@asem.it> wrote:

> The website:
> 
>     http://wiki.minnowboard.org
> 
> doesn't exist anymore. The same pages are moved to:
> 
>     https://www.elinux.org/Minnowboard
> 
> Other improvements concern the introduction of some rst
> semantic markup in the document.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Thanks for updating the URL.  The markup changes are a bit heavy-handed,
though; could I ask you to redo it without that.  In particular, there is
no real need to put file paths in ``literal text``, but that does clutter
up the reading experience significantly.

Thanks,

jon
