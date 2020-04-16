Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92F1AC6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394687AbgDPOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394668AbgDPOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:47:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B2C061A0C;
        Thu, 16 Apr 2020 07:47:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w12so3210324otm.13;
        Thu, 16 Apr 2020 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SzZBIJ1vFMB5OIxa5Nui2vPMLFwAMxv68r5Gb9P72a4=;
        b=ajCfJ1M6r2pZxJFBvjyDS8dD2joULw4EAc5H0mUZ34t9TrnLn82hTVK4ipAPhoLJ3g
         H6Wpxu5xO09esKSA678AUobqdfxkPv+4G2L5gLqxZOc3w9idnRf2OW19iCOkJ4RXl4Q1
         XNiOX/I3JPJlp3dUju+l1JTdKbcI3CNOIJGMAcJjKxEsBV9tJv2pdzgEuUuFerEK0mHq
         CDNHbUGp93DHYehQeGHMdBDIaj+40uajAF8xsfwo8u3p9SKulj+82I+z+LFTZ9PZgNOH
         SoB5Bqg4Pgt6gR2OralSQexTeQ3UbkYiwFmJRSDru20gyW0b6J8xWXSZqBf4qQuE2D4e
         2bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SzZBIJ1vFMB5OIxa5Nui2vPMLFwAMxv68r5Gb9P72a4=;
        b=G8N3SlkVrImm+abMSKvWrclAvW4wHjgPbSMCGekCyZ4GLyvezUS8S91yLmYSVJ8aAz
         5ixieeWM2O0vtJ4j9cYvQgTilTSww5XKtAZdFeEeucvFT8IpizQZDc9q8Q3PSACDc0lH
         pqVEg5D8xUPvB8jncnVehlz7Ax3E3tVVYbLCcGNKhuEwVMTehy5FJ3zkwHRqIreGoit1
         lw3CC81lT5T13oQ51qVLrbzmNVwNqZOyiKz1JJZ6qM5lyFwRErIn79dxgLeo76GgTqgE
         18UfwZZiKwis/ibP2VdGYLVsgNnrDVGe3mwzAO7Sx50j5mEvlua4ZISicZLHVAxy4bRi
         nwuQ==
X-Gm-Message-State: AGi0PuYcQ8GA2mGYYV4wTqiPPI7blaPFi7FpLQ509jnyNMRnRBYyunWM
        ktN+nHrZSg76VdKKiD7i/cJMCsO0UZ4lQhtfuzg=
X-Google-Smtp-Source: APiQypLdEbF3+t9LzDqALjNDG7plEaTTms/SfdlHEm65gdxa0jPdwNRVRRoUCOFXZeveNmrPK2qn+MtBebHlL6rUyeQ=
X-Received: by 2002:a9d:12f6:: with SMTP id g109mr10158623otg.0.1587048429098;
 Thu, 16 Apr 2020 07:47:09 -0700 (PDT)
MIME-Version: 1.0
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 16 Apr 2020 10:46:58 -0400
Message-ID: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
Subject: [Q] devicetree overlays
To:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pantelis, Frank,

A quick question about the state of devicetree overlays. There don't seem to
be many in-kernel overlay users (rcar and fpga only?). Does it make sense for
new projects to use them?

My situation is this: I have hardware which consists of several modules.
Knowledge about the type and location of these modules is located in an
on-board eeprom.

So now I need to assemble a devicetree, by puzzling various 'blobs' together.
This could be done in the bootloader, but also by a rcar-like driver, which
queries the eeprom and inserts devicetree fragments/overlays into a live kernel.

A couple of questions:
- are devicetree overlays here to stay? (given that there are 2 in-kernel users)
- does it make sense to solve the modular devicetree problem in a rcar-like
  fashion?
- is there perhaps a more canonical / idiomatic way to solve this?

Sven
