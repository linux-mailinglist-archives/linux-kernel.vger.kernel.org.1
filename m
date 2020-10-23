Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2D2975D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbgJWRdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:33:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:42242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461541AbgJWRdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:33:46 -0400
IronPort-SDR: +ycL2IN42Nw9S3Pq71noAnulgOs7IJ9Sr169EoRAVHyXzwtaakzI6Hp3/4RjzB/sa0DkMPFmPW
 1mqurgnf2Yhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="165116910"
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="gz'50?scan'50,208,50";a="165116910"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 10:33:41 -0700
IronPort-SDR: itSFbutW010jyJtUlq3EI0mslOrfHhZ8SLq4FxyZcmlj+wMPYyvBly283uh8g6jzwY8uZKc9/M
 vqvM+KDzvHYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,409,1596524400"; 
   d="gz'50?scan'50,208,50";a="354509062"
Received: from lkp-server01.sh.intel.com (HELO cda15bb6d7bd) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2020 10:33:38 -0700
Received: from kbuild by cda15bb6d7bd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kW0wb-00007E-S8; Fri, 23 Oct 2020 17:33:37 +0000
Date:   Sat, 24 Oct 2020 01:33:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, elver@google.com, yzaikin@google.com,
        tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     kbuild-all@lists.01.org, Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
Message-ID: <202010240131.hnUjOylq-lkp@intel.com>
References: <20201023150634.282631-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20201023150634.282631-1-98.arpi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arpitha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on linus/master v5.9 next-20201023]
[cannot apply to tytso-fscrypt/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201023-230827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: x86_64-randconfig-s021-20201023 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-17-g2d3af347-dirty
        # https://github.com/0day-ci/linux/commit/67c9830f2988a5b2153f7bb05396611947ee6677
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201023-230827
        git checkout 67c9830f2988a5b2153f7bb05396611947ee6677
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   fs/ext4/inode-test.c: note: in included file:
>> include/kunit/test.h:1732:9: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> include/kunit/test.h:1732:9: sparse:    unsigned long *
>> include/kunit/test.h:1732:9: sparse:    int *

vim +1732 include/kunit/test.h

73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1147  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1148  #define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1149  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1150  						assert_type,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1151  						ptr,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1152  						NULL)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1153  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1154  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1155   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1156   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1157   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1158   * not evaluate to true.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1159   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1160   * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1161   * to fail when the specified condition is not met; however, it will not prevent
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1162   * the test case from continuing to run; this is otherwise known as an
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1163   * *expectation failure*.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1164   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1165  #define KUNIT_EXPECT_TRUE(test, condition) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1166  	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1167  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1168  #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1169  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1170  				 KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1171  				 condition,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1172  				 fmt,					       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1173  				 ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1174  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1175  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1176   * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1177   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1178   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1179   * not evaluate to false.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1180   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1181   * Sets an expectation that @condition evaluates to false. See
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1182   * KUNIT_EXPECT_TRUE() for more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1183   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1184  #define KUNIT_EXPECT_FALSE(test, condition) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1185  	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1186  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1187  #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1188  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1189  				  KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1190  				  condition,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1191  				  fmt,					       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1192  				  ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1193  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1194  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1195   * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1196   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1197   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1198   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1199   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1200   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1201   * equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1202   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1203   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1204   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1205  #define KUNIT_EXPECT_EQ(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1206  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1207  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1208  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1209  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1210  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1211  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1212  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1213  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1214  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1215  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1216  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1217   * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1218   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1219   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1220   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1221   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1222   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1223   * equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1224   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1225   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1226   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1227  #define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1228  	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1229  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1230  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1231  				      right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1232  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1233  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1234  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1235  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1236  					  left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1237  					  right,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1238  					  fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1239  					  ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1240  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1241  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1242   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1243   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1244   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1245   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1246   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1247   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1248   * equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1249   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1250   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1251   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1252  #define KUNIT_EXPECT_NE(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1253  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1254  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1255  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1256  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1257  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1258  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1259  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1260  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1261  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1262  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1263  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1264   * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1265   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1266   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1267   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1268   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1269   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1270   * equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1271   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1272   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1273   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1274  #define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1275  	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1276  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1277  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1278  				      right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1279  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1280  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1281  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1282  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1283  					  left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1284  					  right,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1285  					  fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1286  					  ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1287  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1288  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1289   * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1290   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1291   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1292   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1293   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1294   * Sets an expectation that the value that @left evaluates to is less than the
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1295   * value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1296   * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1297   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1298   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1299  #define KUNIT_EXPECT_LT(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1300  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1301  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1302  #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1303  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1304  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1305  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1306  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1307  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1308  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1309  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1310  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1311   * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1312   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1313   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1314   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1315   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1316   * Sets an expectation that the value that @left evaluates to is less than or
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1317   * equal to the value that @right evaluates to. Semantically this is equivalent
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1318   * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1319   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1320   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1321  #define KUNIT_EXPECT_LE(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1322  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1323  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1324  #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1325  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1326  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1327  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1328  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1329  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1330  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1331  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1332  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1333   * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1334   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1335   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1336   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1337   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1338   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1339   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1340   * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1341   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1342   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1343  #define KUNIT_EXPECT_GT(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1344  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1345  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1346  #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1347  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1348  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1349  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1350  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1351  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1352  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1353  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1354  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1355   * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1356   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1357   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1358   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1359   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1360   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1361   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1362   * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1363   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1364   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1365  #define KUNIT_EXPECT_GE(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1366  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1367  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1368  #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1369  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1370  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1371  				      left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1372  				      right,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1373  				      fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1374  				      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1375  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1376  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1377   * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1378   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1379   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1380   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1381   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1382   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1383   * equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1384   * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1385   * for more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1386   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1387  #define KUNIT_EXPECT_STREQ(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1388  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1389  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1390  #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1391  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1392  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1393  					  left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1394  					  right,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1395  					  fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1396  					  ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1397  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1398  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1399   * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1400   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1401   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1402   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1403   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1404   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1405   * not equal. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1406   * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1407   * for more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1408   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1409  #define KUNIT_EXPECT_STRNEQ(test, left, right) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1410  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1411  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1412  #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1413  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1414  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1415  					  left,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1416  					  right,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1417  					  fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1418  					  ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1419  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1420  /**
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1421   * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1422   * @test: The test context object.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1423   * @ptr: an arbitrary pointer.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1424   *
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1425   * Sets an expectation that the value that @ptr evaluates to is not null and not
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1426   * an errno stored in a pointer. This is semantically equivalent to
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1427   * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1428   * more information.
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1429   */
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1430  #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1431  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1432  
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1433  #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1434  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1435  						KUNIT_EXPECTATION,	       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1436  						ptr,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1437  						fmt,			       \
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1438  						##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins     2019-09-23  1439  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1440  #define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1441  	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1442  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1443  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1444   * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1445   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1446   * @condition: an arbitrary boolean expression. The test fails and aborts when
e4aea8f8532b55f Brendan Higgins     2019-09-23  1447   * this does not evaluate to true.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1448   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1449   * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
e4aea8f8532b55f Brendan Higgins     2019-09-23  1450   * fail *and immediately abort* when the specified condition is not met. Unlike
e4aea8f8532b55f Brendan Higgins     2019-09-23  1451   * an expectation failure, it will prevent the test case from continuing to run;
e4aea8f8532b55f Brendan Higgins     2019-09-23  1452   * this is otherwise known as an *assertion failure*.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1453   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1454  #define KUNIT_ASSERT_TRUE(test, condition) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1455  	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1456  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1457  #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1458  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1459  				 KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1460  				 condition,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1461  				 fmt,					       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1462  				 ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1463  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1464  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1465   * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1466   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1467   * @condition: an arbitrary boolean expression.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1468   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1469   * Sets an assertion that the value that @condition evaluates to is false. This
e4aea8f8532b55f Brendan Higgins     2019-09-23  1470   * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
e4aea8f8532b55f Brendan Higgins     2019-09-23  1471   * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1472   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1473  #define KUNIT_ASSERT_FALSE(test, condition) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1474  	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1475  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1476  #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1477  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1478  				  KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1479  				  condition,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1480  				  fmt,					       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1481  				  ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1482  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1483  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1484   * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1485   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1486   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1487   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1488   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1489   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55f Brendan Higgins     2019-09-23  1490   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1491   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1492   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1493  #define KUNIT_ASSERT_EQ(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1494  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1495  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1496  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1497  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1498  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1499  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1500  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1501  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1502  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1503  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1504  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1505   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1506   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1507   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1508   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1509   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1510   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55f Brendan Higgins     2019-09-23  1511   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1512   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1513   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1514  #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1515  	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1516  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1517  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1518  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1519  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1520  					  left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1521  					  right,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1522  					  fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1523  					  ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1524  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1525  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1526   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1527   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1528   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1529   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1530   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1531   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55f Brendan Higgins     2019-09-23  1532   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1533   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1534   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1535  #define KUNIT_ASSERT_NE(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1536  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1537  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1538  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1539  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1540  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1541  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1542  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1543  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1544  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1545  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1546  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1547   * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1548   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1549   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1550   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1551   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1552   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1553   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55f Brendan Higgins     2019-09-23  1554   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1555   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1556   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1557  #define KUNIT_ASSERT_PTR_NE(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1558  	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1559  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1560  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1561  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1562  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1563  					  left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1564  					  right,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1565  					  fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1566  					  ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1567  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1568   * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1569   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1570   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1571   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1572   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1573   * Sets an assertion that the value that @left evaluates to is less than the
e4aea8f8532b55f Brendan Higgins     2019-09-23  1574   * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
e4aea8f8532b55f Brendan Higgins     2019-09-23  1575   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1576   * is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1577   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1578  #define KUNIT_ASSERT_LT(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1579  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1580  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1581  #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1582  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1583  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1584  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1585  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1586  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1587  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1588  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1589   * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1590   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1591   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1592   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1593   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1594   * Sets an assertion that the value that @left evaluates to is less than or
e4aea8f8532b55f Brendan Higgins     2019-09-23  1595   * equal to the value that @right evaluates to. This is the same as
e4aea8f8532b55f Brendan Higgins     2019-09-23  1596   * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
e4aea8f8532b55f Brendan Higgins     2019-09-23  1597   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1598   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1599  #define KUNIT_ASSERT_LE(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1600  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1601  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1602  #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1603  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1604  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1605  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1606  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1607  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1608  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1609  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1610  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1611   * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1612   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1613   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1614   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1615   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1616   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55f Brendan Higgins     2019-09-23  1617   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
e4aea8f8532b55f Brendan Higgins     2019-09-23  1618   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1619   * is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1620   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1621  #define KUNIT_ASSERT_GT(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1622  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1623  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1624  #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1625  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1626  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1627  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1628  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1629  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1630  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1631  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1632  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1633   * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1634   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1635   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1636   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1637   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1638   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55f Brendan Higgins     2019-09-23  1639   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
e4aea8f8532b55f Brendan Higgins     2019-09-23  1640   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55f Brendan Higgins     2019-09-23  1641   * is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1642   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1643  #define KUNIT_ASSERT_GE(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1644  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1645  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1646  #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1647  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1648  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1649  				      left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1650  				      right,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1651  				      fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1652  				      ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1653  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1654  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1655   * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1656   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1657   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1658   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1659   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1660   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55f Brendan Higgins     2019-09-23  1661   * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
e4aea8f8532b55f Brendan Higgins     2019-09-23  1662   * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1663   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1664  #define KUNIT_ASSERT_STREQ(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1665  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1666  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1667  #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1668  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1669  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1670  					  left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1671  					  right,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1672  					  fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1673  					  ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1674  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1675  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1676   * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1677   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1678   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1679   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1680   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1681   * Sets an expectation that the values that @left and @right evaluate to are
e4aea8f8532b55f Brendan Higgins     2019-09-23  1682   * not equal. This is semantically equivalent to
e4aea8f8532b55f Brendan Higgins     2019-09-23  1683   * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
e4aea8f8532b55f Brendan Higgins     2019-09-23  1684   * for more information.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1685   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1686  #define KUNIT_ASSERT_STRNEQ(test, left, right) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1687  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1688  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1689  #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1690  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1691  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1692  					  left,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1693  					  right,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1694  					  fmt,				       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1695  					  ##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1696  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1697  /**
e4aea8f8532b55f Brendan Higgins     2019-09-23  1698   * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1699   * @test: The test context object.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1700   * @ptr: an arbitrary pointer.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1701   *
e4aea8f8532b55f Brendan Higgins     2019-09-23  1702   * Sets an assertion that the value that @ptr evaluates to is not null and not
e4aea8f8532b55f Brendan Higgins     2019-09-23  1703   * an errno stored in a pointer. This is the same as
e4aea8f8532b55f Brendan Higgins     2019-09-23  1704   * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
e4aea8f8532b55f Brendan Higgins     2019-09-23  1705   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55f Brendan Higgins     2019-09-23  1706   */
e4aea8f8532b55f Brendan Higgins     2019-09-23  1707  #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1708  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1709  
e4aea8f8532b55f Brendan Higgins     2019-09-23  1710  #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1711  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1712  						KUNIT_ASSERTION,	       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1713  						ptr,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1714  						fmt,			       \
e4aea8f8532b55f Brendan Higgins     2019-09-23  1715  						##__VA_ARGS__)
e4aea8f8532b55f Brendan Higgins     2019-09-23  1716  
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1717  /**
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1718   * kunit_param_generator_helper() - Helper method for test parameter generators
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1719   * 				    required in parameterized tests.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1720   * @test: The test context object.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1721   * @prev_param: a pointer to the previous test parameter, NULL for first parameter.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1722   * @param_array: a user-supplied pointer to an array of test parameters.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1723   * @array_size: number of test parameters in the array.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1724   * @type_size: size of one test parameter.
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1725   */
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1726  static inline void *kunit_param_generator_helper(struct kunit *test,
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1727  					void *prev_param,
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1728  					void *param_array,
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1729  					size_t array_size,
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1730  					size_t type_size)
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1731  {
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23 @1732  	KUNIT_ASSERT_EQ(test, (prev_param - param_array) % type_size, 0);
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1733  
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1734  	if (!prev_param)
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1735  		return param_array;
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1736  
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1737  	KUNIT_ASSERT_GE(test, prev_param, param_array);
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1738  
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1739  	if (prev_param + type_size < param_array + (array_size * type_size))
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1740  		return prev_param + type_size;
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1741  	else
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1742  		return NULL;
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1743  }
2c09a7974ce3b43 Arpitha Raghunandan 2020-10-23  1744  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2Sg8lw2q/wJa7s1+YwUCAA==

--cWoXeonUoKmBZSoM--
