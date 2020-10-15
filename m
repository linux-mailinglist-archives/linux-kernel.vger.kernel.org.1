Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60928EE49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgJOIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgJOIMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:12:18 -0400
Received: from mail.kernel.org (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8054322243;
        Thu, 15 Oct 2020 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602749537;
        bh=33z8nKoGuLLm2mUPGpRI4AurCQK+VR3FL+LGlgPxZoM=;
        h=From:To:Cc:Subject:Date:From;
        b=NK6Sma4BXORk2pGQzy2i4MKyCEXyZNJSwADCLDA0thhDK/I47NCSXnxot2+3k7Wns
         c5l5CM+JYn4MuB9wOAVlQ3Y3mvWZzT7fOxhqvlJC2uxbl58HGhzwJ9VpzM6ORnOk9q
         c3CWTFKyKw1TShnBTMNKcJ0sGuOyQUBG3l5o07QM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSyMw-000MSj-TZ; Thu, 15 Oct 2020 10:12:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] Fix build issues with Sphinx development tree
Date:   Thu, 15 Oct 2020 10:12:10 +0200
Message-Id: <cover.1602749214.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Sphinx pull:
	https://github.com/sphinx-doc/sphinx/pull/8313

Fixes the C domain name conflicts when both a function and an
enum, struct or union have the same name. Those fixes will generate
new C domain warnings if an enum is defined using :c:struct.

So, we need to use different tags for structs or union. Thankfully,
such change is backward compatible with Shinx 3.x. The first
patch address it.

The second patch fix an issue at conf.py.

While Sphinx 4.0 was not released yet, the Sphinx development branch
is using 4.0.0 as its version. There is a small issue at the code that
excludes some macros from functions, if Sphinx major version is > 3.

Mauro Carvalho Chehab (2):
  scripts: kernel-doc: use :c:union when needed
  sphinx: conf.py: properly handle Sphinx 4.0

 Documentation/conf.py | 2 +-
 scripts/kernel-doc    | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.26.2


