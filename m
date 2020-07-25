Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F14F22D7CE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgGYNCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 09:02:53 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34144 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGYNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:02:52 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BDR7Z19ynz4D;
        Sat, 25 Jul 2020 15:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1595682170; bh=D0/hPNw6b/gGh/gKDmVNpzkoyYq/5IAZlJL18d7KTmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mV4P+rZdsMRWGuUEjtrNLDiuN1dF5pTE6M6G4V2OH00Jl1H4C2x+cIrMLph/K+tal
         vPHxMYiVkFEc0u2w+zWc/Zb5teEQ0CB511nn7uvxnVRUnanhioZWy69U6IldE+nOyK
         CygVmGUXjNxySZbNs6ZwPA7phh8rQ5rVwy+DJP8wBfyE+Ooiy5GCSBdIfFr7EnqTPA
         QsHQO7kIMDsE9MPShC76GbXU4ViiO3u32Hsi2d7akvNeVXzoEY8DsgSBzJXhx8iiU3
         9fsCNwBiCL7LAb/i/fjbllXKALuumRh5KnlDZP7TRVm6BulZnPc8JibMet7wqVmji3
         S06MMunJcRh+w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Sat, 25 Jul 2020 15:02:48 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        apw@canonical.com, joe@perches.com, colin.king@canonical.com,
        sj38.park@gmail.com, jslaby@suse.cz, pavel@ucw.cz
Subject: Re: checkpatch: support deprecated terms checking
Message-ID: <20200725130248.GC18633@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200611062550.20113-2-sjpark@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see that this patch went into next and is already inciting people to
do wrong things [1]. Can you please fix it to require '--subjective'
switch or otherwise mark it clearly as suggestion-only?

The coding-style as in Linus' master says about *NEW* uses of the words
listed (those introductions I expect to be actually rare) and not about
existing use in the code or industry. Making a noise about all uses
found surely will generate a lot more irrelevant patches.

[1] https://www.spinics.net/lists/linux-tegra/msg51849.html

Best Regards
Micha³ Miros³aw
