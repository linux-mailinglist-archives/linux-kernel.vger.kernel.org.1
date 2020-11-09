Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503732AC397
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgKISVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKISVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:21:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAECC0613CF;
        Mon,  9 Nov 2020 10:21:38 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5B71E60B;
        Mon,  9 Nov 2020 18:21:37 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:21:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/26] Make reporting-bugs easier to grasp and
 yet more detailed
Message-ID: <20201109112136.0634a356@lwn.net>
In-Reply-To: <7910cf25-4aa9-e33d-704c-33ab91ab713b@leemhuis.info>
References: <cover.1601541165.git.linux@leemhuis.info>
        <7910cf25-4aa9-e33d-704c-33ab91ab713b@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 12:01:56 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> @Jon: I'd be really appreciate to hear your thoughts on this.

Seems like it's time to post a new version with all of your feedback so
far reflected, and we'll go from there?

Thanks,

jon
