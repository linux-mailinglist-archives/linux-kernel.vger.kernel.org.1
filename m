Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1025D905
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgIDMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgIDMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:55:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EDC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 05:55:17 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so7007945ioa.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W2Yrc8EmVMyvmKs3hnNcpX4KAZYwMH/LneJrTxAjdY0=;
        b=NOInk+6qulCx71PLTfBW20+ac5pJklAQk3okPu2X0hISmFa2EzB+FKTTl1sMxErlxy
         IpbfeGqBbkWeHU/jLBfa2GUsikyMiKylnLKeVAe5+jefLMauJIklaWfyT2tXv0eRqrOb
         UNaMnNtAxBQlF7g+MqrVCJ3O6Gh/ibBL8OdYmVwQfq93ImWF7aOdzaQgiExrGQp/IXeQ
         PD+gT5GbrEhsac9HMAfpKA2GZjRS4CSdCKE9VuvVFdqL3JumRsImStGCtkT/XzksCXLP
         51axjO5nFTnSXu7zr+GrBYW8nlnFYcDnLD9WcDKALk4kfQCUhPAdYc/dAYyx08+A0vEy
         c85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=W2Yrc8EmVMyvmKs3hnNcpX4KAZYwMH/LneJrTxAjdY0=;
        b=KdhL3IdAlii9TQMBFwfLHv1rxMeDCLL31bBoN7MXAdFZKTao1Wgq7HYUIftU6vpXa9
         SIl6RMtrAUYO8nhsNADoPY+8ObfhlEz+s2pAfoONOaaWZilonNlUgs4W1nK/dpkYUrWJ
         evp9GRmxfwuwUvhEPw5DcfcOAiJCQGBO+4SJ83LRFNNzBsHvMnO2s0NDt0ijqKBabBme
         TGaGO1pM07+BRDOPMDSKOH05cS5iCd3q0VPmdGO6RY1Ff37PFz8lWzITEN7DK6Ryo213
         j58Y46cUugOQUfHJHl8c+WSLktkTzgiQCX8NSlcYfTf7TxfWcIAdPa37Hnk650Vf8EGk
         2kEA==
X-Gm-Message-State: AOAM531P+zXHcllOrZWe2X8fYhe4pBPvb3u/v+xTpUJhQ3ocPB51/yJc
        X1Y/pks1cc5aE9UNz+vBsxPCHz919jqJkib3t8A=
X-Google-Smtp-Source: ABdhPJxG1RIOTVCVar9Bc7VS/QHR0usCrEEJE4Ns1+6QPCdLoLIUb+VZ1x6bRUeozxLNdo6NSQMxS/wdXAoxjJUPYAE=
X-Received: by 2002:a02:8802:: with SMTP id r2mr8249679jai.75.1599224116749;
 Fri, 04 Sep 2020 05:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a92:650f:0:0:0:0:0 with HTTP; Fri, 4 Sep 2020 05:55:16 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <andersonrobertpass11@gmail.com>
Date:   Fri, 4 Sep 2020 05:55:16 -0700
Message-ID: <CAOga3ccMCrU9SGyhqMd2X1fNrWLOaQDa3P9ZA6SVR45xMt7E0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

576O5aW955qE5LiA5aSp77yM5oiR55qE5aW95pyL5Y+L44CCDQoNCuS7iuWkqei/h+W+l+WlveWQ
l++8n+aIkeW3sue7j+W+iOS5heayoeacieaUtuWIsOaCqOeahOadpeS/oeS6hg0K5Zyo5L2g6Lqr
6L655LuK5aSp77yM5oiR5b6I6auY5YW05Zyw6YCa55+l5oKo5oiR5ZyoDQrov5nkupvpgZfkvKDo
tYTph5HnmoTmjqXmlLbvvIzlnKjmlrDnmoTlkIjkvZzkuIvovaznp7sNCuadpeiHquWNsOW6puS6
mua0sueahOWQiOS9nOS8meS8tOOAguS7luaYr+WKoOaLv+Wkp+S6uu+8jOS9huS9j+WcqOWNsOW6
pu+8jOS9huebruWJjQ0K5oiR5p2l5Y2w5bqm5LuO5LqL5oqV6LWE6aG555uu77yM5Y2g5oiR55qE
5YWo6YOo5Lu96aKdDQrmlbDnmb7kuIfnvo7lhYPjgILlkIzml7bvvIzmiJHmsqHmnInlv5jorrDk
vaDov4fljrvnmoTliqrlipvlkozlsJ3or5UNCuW4ruWKqeaIkemAmui/h+i/meS6m+mBl+S8oOeW
l+azle+8jOWNs+S9v+Wksei0peS6hg0K5pyJ5pe277yM5oiR5Lus5biM5pyb5oKo5LiO5oiR5Zyo
6KW/5aSa5ZOl5YWx5ZKM5Zu95rSb576O55qE56eY5Lmm6IGU57O7DQrpnZ7mtLLvvIzlpbnlj6tT
b2xvbW9uIEJyYW5kee+8jOi/meaYr+S7lueahOeUteWtkOmCruS7tuWcsOWdgO+8iHNvbG9tb25i
cmFuZHkwMDRAZ21haWwuY29t77yJDQror7forqnku5bogZTns7vpnZ7mtLLlvIDlj5Hpk7booYwN
CuS/neeVmSQgMzUwLDAwMC4wMOS9nOS4uuaCqOeahOi1lOWBv+mHke+8jOi/meeslOi1lOWBv+mH
kQ0K6L+H5Y6755qE5omA5pyJ5Yqq5Yqb5ZKM6L+H5Y675a+55oiR55qE5biu5YqpDQrlpITnkIbj
gILmiJHnnJ/nmoTlvojmhJ/osKLmgqjlvZPml7bnmoTliqrlipvjgILmhJ/op4nlpoLmraQNCuWF
jei0ue+8jOS4juaIkeeahOenmOS5puaJgOe9l+mXqMK35biD5YWw6L+q5YWI55Sf6IGU57O777yM
5bm25ZGK6K+J5aW55Zyo5ZOq6YeMDQrpnZ7mtLLlvIDlj5Hpk7booYzlsIbmjZDotaDmgLvorqEz
NTAsMDAw576O5YWD44CCDQoNCuivt+eri+WNs+mAmuefpeaIkemdnua0suW8gOWPkemTtuihjOi9
rOW4kA0K6LWE6YeRJCAzNTAuMDAwLjAwDQrliLDmiJHnmoTpk7booYzluJDmiLfvvIznjrDlnKjm
iJHlm6DkuLoNCuWboOatpO+8jOaIkeS4juaWsOWQiOS8meS6uuS4gOi1t+i/m+ihjOeahOaKlei1
hOmhueebrg0K6YCa6L+H5LuW55qE55S15a2Q6YKu5Lu25Zyw5Z2A6IGU57O75omA572X6Zeowrfl
uIPlhbDov6rlhYjnlJ/vvIwNCueri+WNs+S7o+ihqOaCqOS4jumdnua0suW8gOWPkemTtuihjOiB
lOezu+OAgg0K6L+c56a7Q292aWQgMTnjgIINCg0K5bCK5pWs77yMDQrnvZfkvK/nibnCt+WuieW+
t+ajruWNmuWjqw0K
