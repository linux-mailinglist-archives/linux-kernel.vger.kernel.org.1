Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF729FEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ3HlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ3HlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:03 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75944221E2;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=uiRmSgXfI9ivrjgPVAKD8XrgFsi/teeMzg7Qn9tPCZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWaiUhISbbOVKIZWKe4sNNM4nEIBsqx5PIxxPHXBDFlFvS8n9lDzi1cXwn6jKCP83
         PpSRr+grcMTL8V8sGAcX1OdofzlSTwCGk2cwQlpFGrNZz1B/kmWDspx4SuIxn0Qihu
         +uZ+b/t50jLqAwyfF9uN0MCmOtyMJwHljU1W5khA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004OfU-EW; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/39] scripts: get_abi.pl: output users in ReST format
Date:   Fri, 30 Oct 2020 08:40:26 +0100
Message-Id: <83def2a692c4c678f21ee6e76b66a54d2be1e796.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the script only outputs Users on search. Print it
also in ReST format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 1d1408fad130..e5a5588a8639 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -371,6 +371,14 @@ sub output_rest {
 				print "- :ref:`$content <$label>`\n\n";
 			}
 		}
+
+		if (defined($data{$what}->{users})) {
+			my $users = $data{$what}->{users};
+
+			$users =~ s/\n/\n\t/g;
+			printf "Users:\n\t%s\n\n", $users if ($users ne "");
+		}
+
 	}
 }
 
-- 
2.26.2

