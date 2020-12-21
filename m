Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B942DFEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgLURQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgLURPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608570862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wfN0o0JokmbNz9DafEtBUD4PMjxJrKYE3OGEsWN7KpM=;
        b=EeUVgbMXAoaj/NvdCoZq0dSQC4ZvSzSkkYcHtyiF6ZevQYSu87XP95JCY3qnlxcPOU2q0x
        iT+tVGFV2BApyLJRDhQEfjiZFqZ52ugN8VE8a0UVqg711pL6G6Wnw8YgSRE7I2Hmp+/46U
        ceLw0S173bBI+69vye8zVexKYfqoRbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-tWC4IxGdNQ-Ac7YKD7fj0g-1; Mon, 21 Dec 2020 12:14:18 -0500
X-MC-Unique: tWC4IxGdNQ-Ac7YKD7fj0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DACDB1934108;
        Mon, 21 Dec 2020 17:14:16 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523865D9CA;
        Mon, 21 Dec 2020 17:14:15 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux Containers List <containers@lists.linux-foundation.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Eric Paris <eparis@parisplace.org>, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v10 09/11] contid: interpret correctly CONTAINER_ID contid field csv
Date:   Mon, 21 Dec 2020 12:12:49 -0500
Message-Id: <20201221171251.2610890-10-rgb@redhat.com>
In-Reply-To: <20201221171251.2610890-1-rgb@redhat.com>
References: <20201221171251.2610890-1-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONTAINER_ID record contid field can contain comma-separated values
when accompanying a NETFILTER_PKT record.  Records appeared interpreted
as such:

Wrong:
	CONTAINER_ID msg=audit(2019-04-10 13:20:18.746:1690) : contid=777 666,333
Right:
	CONTAINER_ID msg=audit(2019-04-10 13:20:18.746:1690) : contid=777,666,333

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/ausearch-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/ausearch-report.c b/src/ausearch-report.c
index 416c2b13fa6a..754b28af2cb6 100644
--- a/src/ausearch-report.c
+++ b/src/ausearch-report.c
@@ -279,7 +279,7 @@ no_print:
 			if (str && val && (str < val)) {
 			// Value side  has commas and another field exists
 			// Known: LABEL_LEVEL_CHANGE banners=none,none
-			// Known: ROLL_ASSIGN new-role=r,r
+			// Known: ROLE_ASSIGN new-role=r,r
 			// Known: any MAC LABEL can potentially have commas
 				int ftype = auparse_interp_adjust_type(n->type,
 								name, val);
@@ -293,9 +293,11 @@ no_print:
 			} else if (str && (val == NULL)) {
 			// Goes all the way to the end. Done parsing
 			// Known: MCS context in PATH rec obj=u:r:t:s0:c2,c7
+			// Known: CONTAINER_ID/OP old-/contid can be a comma-separated list
 				int ftype = auparse_interp_adjust_type(n->type,
 								name, ptr);
-				if (ftype == AUPARSE_TYPE_MAC_LABEL)
+				if (ftype == AUPARSE_TYPE_MAC_LABEL
+				    || ftype == AUPARSE_TYPE_CONTID)
 					str = NULL;
 				else {
 					*str++ = 0;
-- 
2.18.4

