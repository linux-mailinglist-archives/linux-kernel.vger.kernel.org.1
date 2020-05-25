Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8251F1E12E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbgEYQpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbgEYQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:45:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C4C061A0E;
        Mon, 25 May 2020 09:45:03 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1F9F4A2;
        Mon, 25 May 2020 16:45:02 +0000 (UTC)
Date:   Mon, 25 May 2020 10:45:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] docs: filesystems: add info about efivars
 content
Message-ID: <20200525104502.5fc16f83@lwn.net>
In-Reply-To: <20200519084128.12756-1-f.suligoi@asem.it>
References: <20200515114054.2496c171@lwn.net>
        <20200519084128.12756-1-f.suligoi@asem.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 10:41:27 +0200
Flavio Suligoi <f.suligoi@asem.it> wrote:

> When an EFI variable is reading from:
> 
> /sys/firmware/efi/efivars
> 
> (for example using "hexdump"), the first 4 bytes of the
> output are not the real EFI variable data, but the variable
> attributes (in little-endian format).
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Both patches applied, thanks.

jon
