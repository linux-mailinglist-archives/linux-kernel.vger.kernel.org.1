Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A52D41EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgLIMRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:17:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731453AbgLIMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607516133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHzSkHSzjoS+gFz+yV6eFCrIuBgpftRSDaDJB/PyNOc=;
        b=GCXa7BGwI4mSAu4rd8EPsUBamATmQDrsnlKQSdRyb5HjrMQTiADqAkObO6xQqI2aEoVfUk
        8bmddXqmN1g0fqHkZNzcI65rOLJX94zhHAWkhN213nyXSjcjB2BVujk530kFPFy19GEtts
        SlcmeBmF7rDUUjUTcymzG8JLSgjYRwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-A6L93quOP9SIAuYG9bpamQ-1; Wed, 09 Dec 2020 07:15:29 -0500
X-MC-Unique: A6L93quOP9SIAuYG9bpamQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADEB800D55;
        Wed,  9 Dec 2020 12:15:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D93796E521;
        Wed,  9 Dec 2020 12:15:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/18] crypto: asymmetric_keys: fix some comments in
 pkcs7_parser.h
From:   David Howells <dhowells@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, keyrings@vger.kernel.org,
        dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:15:26 +0000
Message-ID: <160751612606.1238376.15142782931893308010.stgit@warthog.procyon.org.uk>
In-Reply-To: <160751606428.1238376.14935502103503420781.stgit@warthog.procyon.org.uk>
References: <160751606428.1238376.14935502103503420781.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.
Change "THis" to "This".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
---

 crypto/asymmetric_keys/pkcs7_parser.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.h b/crypto/asymmetric_keys/pkcs7_parser.h
index 6565fdc2d4ca..e17f7ce4fb43 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.h
+++ b/crypto/asymmetric_keys/pkcs7_parser.h
@@ -41,10 +41,9 @@ struct pkcs7_signed_info {
 	 *
 	 * This contains the generated digest of _either_ the Content Data or
 	 * the Authenticated Attributes [RFC2315 9.3].  If the latter, one of
-	 * the attributes contains the digest of the the Content Data within
-	 * it.
+	 * the attributes contains the digest of the Content Data within it.
 	 *
-	 * THis also contains the issuing cert serial number and issuer's name
+	 * This also contains the issuing cert serial number and issuer's name
 	 * [PKCS#7 or CMS ver 1] or issuing cert's SKID [CMS ver 3].
 	 */
 	struct public_key_signature *sig;


