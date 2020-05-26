Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95F81CDB05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEKNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:16:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:51376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEKNQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:16:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F2E04AC22;
        Mon, 11 May 2020 13:16:05 +0000 (UTC)
Date:   Mon, 11 May 2020 15:16:02 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update LIVE PATCHING file list
In-Reply-To: <20200511061014.308675-1-kamalesh@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.21.2005111515460.7586@pobox.suse.cz>
References: <20200511061014.308675-1-kamalesh@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020, Kamalesh Babulal wrote:

> The current list of livepatching files is incomplete, update the list
> with the missing files. Included files are ordered by the command:
> 
> ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
