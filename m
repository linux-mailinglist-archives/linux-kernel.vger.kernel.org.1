Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424792971AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbgJWOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:48:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58794 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbgJWOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:48 -0400
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 87F831F467BE;
        Fri, 23 Oct 2020 15:47:47 +0100 (BST)
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        anton.ivanov@cambridgegreys.com
Subject: Re: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Date:   Fri, 23 Oct 2020 15:47:31 +0100
Message-Id: <20201023144731.303328-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019211049.22524-1-richard@nod.at>
References: <20201019211049.22524-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:10:49PM +0200, Richard Weinberger wrote:
> Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
> a bug in uml, we forgot to call the destructor.
> While we are here, give x a sane name.
> 
> Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Tested-by: Christopher Obbard <chris.obbard@collabora.com>
