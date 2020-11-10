Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99572ADD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgKJRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:49:16 -0500
Received: from out1.migadu.com ([91.121.223.63]:2964 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJRtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:49:07 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2020 12:49:06 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1605030044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Z9zeRDZ2j+RYvYV/sSKPfJ23GM432ud8SVt0CMnE+Mc=;
        b=ikA/ah51Ygf4ph1diEptsMPmvqAc8dWOy8moZN6IdZk0XWv3rbTfpu2er8ZcEmmMiS4JUY
        qIiVv4SuAnOqlKwThZOKWZi5Nfd36v60fpIRsE+G7mlWqiDzqZaJn4XCKCOxS+VgkXmEge
        QJmOQ+ZKOymLH8xxH3VG3y4/Fr7CtBCVc/1oUnMgra4iXLLQrKX0SnpzxBtntSkFq9NZ4y
        7EEhd08djCLvIQGPwa01TQXuvvF2RybfXIzhZbJ0PDVkxIVyUO2YhFPci2GDMav4UveOYb
        0OeWULgT+3AfQJY5jsKCAmKq7m62hOHq461w71vTWLCAx0aKo1zvPVrYiY+nDw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <lukas.bulwahn@gmail.com>, <joe@perches.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH v2] Documentation: include sign off for reverts
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Aditya Srivastava" <yashsri421@gmail.com>, <corbet@lwn.net>
Date:   Tue, 10 Nov 2020 13:40:18 -0400
Message-Id: <C6ZRNNLCPJJS.21CMC9SORJPVR@taiga>
In-Reply-To: <20201110173949.31440-1-yashsri421@gmail.com>
X-Authenticated-User: sir@cmpwn.com
X-Spam-Score: 1.64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 10, 2020 at 1:39 PM EDT, Aditya Srivastava wrote:
> using your real name (sorry, no pseudonyms or anonymous contributions.)
> This will be done for you automatically if you use ``git commit -s``.
> +Also reverts should include a Signed-off-by. ``git revert -s`` does
> +that for you.

The language here is a bit odd, try this:

Reverts should also include "Signed-off-by". ``git revert -s`` does that
for you.
