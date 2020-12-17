Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5212DCD73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgLQIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgLQIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:14:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8EAC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:14:19 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpoQT-00AYWE-Gs; Thu, 17 Dec 2020 09:14:17 +0100
Message-ID: <104d6f30adf16d30a8d85e0d0813a85ad563e09c.camel@sipsolutions.net>
Subject: Re: [PATCH] gdb: correct sys.path insertion
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>
Date:   Thu, 17 Dec 2020 09:14:00 +0100
In-Reply-To: <b92ec4f5-42ef-8d8c-bf37-90e1476b95e5@siemens.com>
References: <20201216143646.82aa53af4af8.I04934c69a9f3abac5ba6d542f823898357fd0e11@changeid>
         <b92ec4f5-42ef-8d8c-bf37-90e1476b95e5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> > -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> > +sys.path.insert(0, os.path.dirname(__file__))
> >  
> >  try:
> >      gdb.parse_and_eval("0")
> > 
> 
> How did you test that, which setup? I just ran "gdb
> <linux>/build/vmlinux", and "python print(sys.path)" didn't expose this
> duplication. So your change would actually break that common case.

Oh, seems that was my mistake. I was trying to (explicitly) load the
file as "scripts/gdb/vmlinux-gdb.py" rather than using the symlink that
gets installed.

Never mind.

johannes

